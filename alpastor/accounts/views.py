from django.core.exceptions import MultipleObjectsReturned
from django.db import IntegrityError
from django.shortcuts import render, redirect
from django.contrib.auth import logout
from django.contrib.auth import login as auth_login
from django.contrib.auth.decorators import user_passes_test
from accounts.forms import LoginForm, ResetPasswordForm
from accounts.models import User, ResetToken
from epita.models import Student, Course, StudentCourse, Professor, string_to_choice, choice_to_string
from epita.forms import CourseForm, StudentCourseForm
from rest_framework import generics
from rest_framework.exceptions import bad_request
from django.http import HttpResponseRedirect, JsonResponse, QueryDict
from django.views.generic import View
from django.utils.crypto import get_random_string
from django.utils import timezone
from django.core.mail import EmailMultiAlternatives
from django.template.loader import get_template, render_to_string
from django.conf import settings
from django_countries import countries
from django.core.files import File
import json
import re
import enum
import logging

logger = logging.getLogger(__name__)

class ReturnCodes(enum.Enum):
    OK = 0
    ERR_USER_EXISTS = 1
    ERR_INVALID_FIELD = 2
    ERR_INVALID_TOKEN = 3

# Create your views here.
def login(request):
    logout(request)
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            auth_login(request, form.get_user())
            return redirect(request.GET.get('next', 'home'))
    else:
        form = LoginForm()

    return render(request, 'accounts/login.html', {'form': form})

@user_passes_test(lambda u: u.is_superuser)
def manageusers(request):
    course_form = CourseForm()
    student_course_form = StudentCourseForm()
    return render(request, 'accounts/manage_users.html', {
        'programs': Student.PROGRAM_CHOICES,
        'specializations': Student.SPECIALIZATION_CHOICES,
        'seasons': Student.SEASON_CHOICES,
        'course_form': course_form,
        'student_course_form': student_course_form,
        'countries': list(countries)
    })

class SaveNewCourse(View):
    def get(self, request, *args, **kwargs):
        return bad_request(request, exception="Forbidden")

    def post(self, request, *args, **kwargs):
        rc = 200
        msg_success = "[PASS] created new course with code {}"
        msg_fail = "[FAIL] could not create new course with code {}"

        data = QueryDict(request.body).dict()
        form = CourseForm(data)
        if form.is_valid():
            logger.info("Saving new course=[{}] {}".format(data['code'], data['title']))
            response_msg = msg_success.format(data['code'])
            form.save()
        else:
            logger.warning("Attempted to save invalid form")
            response_msg = msg_fail.format(data['code'])
            rc = 400
        return JsonResponse(status=rc, data={'message': response_msg})

class AddStudentCourse(View):
    def post(self, request, **kwargs):
        rc = 200
        numUpdated = 0
        msg_success = "[PASS] added {} user(s) to the course {}"
        msg_fail = "[FAIL] could not add users to course {}"

        course_id = QueryDict(request.body).get('course_id')
        program = QueryDict(request.body).get('program')
        specialization = QueryDict(request.body).get('specialization')
        intake_season = QueryDict(request.body).get('intake_season')
        intake_year = QueryDict(request.body).get('intake_year')

        students = Student.objects.filter(
            program=program,
            specialization=specialization,
            intake_season=intake_season,
            intake_year=intake_year
        )

        try:
            course = Course.objects.get(id=course_id)
        except:
            logger.warning("Error trying to find course by adding studentcourses")
            response_msg = msg_fail.format(course_id)
            return JsonResponse(status=400, data={'message': response_msg})

        if not course:
            logger.warning("Course does not exist, adding studentcourses")
            response_msg = msg_fail.format(course_id)
            return JsonResponse(status=400, data={'message': response_msg})

        for student in students:
            _, created = StudentCourse.objects.update_or_create(student_id=student, course_id=course)
            if created:
                numUpdated = numUpdated + 1

        response_msg = msg_success.format(numUpdated, course.verbose_title())
        logger.info(response_msg)

        return JsonResponse(status=rc, data={'messages': response_msg})

class DeleteStudentCourse(View):
    def post(self, request, **kwargs):
        rc = 200
        msg_success = "[PASS] removed user(s) from the course {}"
        msg_fail = "[FAIL] could not remove users from course {}"

        course_id = QueryDict(request.body).get('course_id')
        program = QueryDict(request.body).get('program')
        specialization = QueryDict(request.body).get('specialization')

        students = Student.objects.filter(
            program=program,
            specialization=specialization
        )

        try:
            course = Course.objects.get(id=course_id)
        except:
            logger.warning("Error trying to find course by removing studentcourses")
            response_msg = msg_fail.format(course_id)
            return JsonResponse(status=400, data={'messages': response_msg})

        if not course:
            logger.warning("Course does not exist, removing studentcourses")
            response_msg = msg_fail.format(course_id)
            return JsonResponse(status=400, data={'messages': response_msg})

        for student in students:
            StudentCourse.objects.filter(student_id=student, course_id=course).delete()

        response_msg = msg_success.format(course.verbose_title())
        logger.info(response_msg)

        return JsonResponse(status=rc, data={'messages': response_msg})

class ProcessUserCSVData(generics.ListCreateAPIView):
    first_name_opts = ["prenom", "first", "first_name", "firstname", "first name"]
    last_name_opts = ["nom", "last", "last_name", "lastname", "surname", "sur_name", "last name", "sur name"]
    program_opts = ["maj", "prog", "program", "major", "majeur"]
    email_opts = ["email", "mail", "courriel"]
    country_opts = ["country", "pays"]
    specialization_opts = ["specialization"]
    semester_opts = ["intake", "intake semester", "semestre", "semester"]

    csv_positions = {
        'first_name' : -1,
        'last_name': -1,
        'email': -1,
        'program': -1,
        'country': -1,
        'specialization': -1,
        'intake_semester': -1,
    }

    def get(self, request, *args, **kwargs):
        return bad_request(request, exception="Forbidden")

    def post(self, request, *args, **kwargs):
        all_users = []
        try:
            csv_file = request.FILES["file"]
            if not csv_file.name.endswith('.csv'):
                logger.error(request, 'File is not CSV type')
                return HttpResponseRedirect('manageusers')
        except Exception as e:
            logger.error("Unable to process file. " + repr(e))
            return HttpResponseRedirect('manageusers')

        file_data = csv_file.read().decode("utf-8")

        lines = file_data.split("\n")
        fields = lines[0].split(",")

        # Determine the field order for the CSV
        for i,field in enumerate(fields):
            if field.lower() in self.first_name_opts:
                self.csv_positions['first_name'] = i
            elif field.lower() in self.last_name_opts:
                self.csv_positions['last_name'] = i
            elif field.lower() in self.email_opts:
                self.csv_positions['email'] = i
            elif field.lower() in self.program_opts:
                self.csv_positions['program'] = i
            elif field.lower() in self.country_opts:
                self.csv_positions['country'] = i
            elif field.lower() in self.specialization_opts:
                self.csv_positions['specialization'] = i
            elif field.lower() in self.semester_opts:
                self.csv_positions['intake_semester'] = i

        # Validate CSV headers
        if self.csv_positions['email'] < 0:
            return bad_request("Cannot find email in CSV", exception="BadCSV")
        elif self.csv_positions['first_name'] < 0:
            return bad_request("Cannot find first name in CSV", exception="BadCSV")
        elif self.csv_positions['last_name'] < 0:
            return bad_request("Cannot find last name in CSV", exception="BadCSV")
        elif self.csv_positions['program'] < 0:
            return bad_request("Cannot find program in CSV", exception="BadCSV")

        # Get override data (if any)
        override_specialization = request.POST.get('overrideSpecialization')
        override_semester_season = request.POST.get('overrideSemesterSeason')
        override_semester_year = request.POST.get('overrideSemesterYear')
        override_country = request.POST.get('overrideCountry')

        for line in lines[1:]:
            user = {
                'first_name': "",
                'last_name': "",
                'program': "",
                'specialization': "",
                'semester_season': "",
                'semester_year': "",
                'email': "",
                'type': "Student",
                'country': ""
            }

            if line == "":
                continue

            fields = line.split(',')

            user['first_name'] = fields[self.csv_positions['first_name']]
            user['last_name'] = fields[self.csv_positions['last_name']]
            user['program'] = fields[self.csv_positions['program']]
            user['email'] = fields[self.csv_positions['email']]

            # Country
            if self.csv_positions['country'] >= 0:
                user['country'] = fields[self.csv_positions['country']]

            if user['country'] == "" and override_country != None:
                user['country'] = override_country

            # Specialization
            if self.csv_positions['specialization'] >= 0:
                user['specialization'] = fields[self.csv_positions['specialization']]

            if user['specialization'] == "" and override_specialization != None:
                user['specialization'] = override_specialization

            # Intake Semester
            if self.csv_positions['intake_semester'] >= 0:
                parts = fields[self.csv_positions['intake_semester']].split(' ')
                year_match = re.match("\d{4}", parts[0], re.M|re.I)
                if (year_match):
                    user['semester_year'] = parts[0]
                    user['semester_season'] = parts[1]
                else:
                    user['semester_year'] = parts[1]
                    user['semester_season'] = parts[1]

            if user['semester_season'] == "" and override_semester_season != None:
                user['semester_season'] = override_semester_season

            if user['semester_year'] == "" and override_semester_year != None:
                user['semester_year'] = override_semester_year

            all_users.append(user)

        logger.info("Processing CSV user file with {} potential users".format(len(all_users)))

        return JsonResponse(all_users, safe=False)

class SaveNewUsers(View):
    def get(self, request, *args, **kwargs):
        return bad_request(request, exception="Forbidden")

    def post(self, request, *args, **kwargs):
        length = int(request.POST.get('length'))
        file = None

        response_code = 200
        response_messages = []

        for i in range(0,length):
            # the key will be just the integer offset
            user = json.loads(request.POST.get(str(i)))
            file_key = "photo{0}".format(i)

            if file_key in request.FILES:
                file = request.FILES[file_key]

            if user['isProfessor'] == True:
                (rc, msg) = self.processNewProfessor(user, file)
            else:
                (rc, msg) = self.processNewStudent(user, file)

            response_messages.append(msg)
            if rc != ReturnCodes.OK:
                response_code = 400

        return JsonResponse(status=response_code, data={'messages': response_messages})

    def processNewProfessor(self, professor, file):
        err_msg_template = "[FAIL] {} - [first_name={}, last_name={}, email_login={}]"
        success_msg_template = "[PASS] Created professor - [first_name={}, last_name={}, email_login={}]"

        first_name = professor['firstName']
        last_name = professor['lastName']
        email_login = professor['emailLogin']
        external_email = professor['externalEmail']
        phone = professor['phone']

        # Ensure all required data is there first
        if first_name == "" or last_name == "":
            logger.error("Attempted to add student with no name")
            return (ReturnCodes.ERR_INVALID_FIELD, err_msg_template.format(
                "Name empty", first_name, last_name, email_login))

        if email_login == "":
            logger.error("Attempted to add student with no primary email")
            return (ReturnCodes.ERR_INVALID_FIELD, err_msg_template.format(
                "Email empty", first_name, last_name, email_login))

        try:
            newUser = User.objects.create_user(
                email=email_login,
                password="epita",
                first_name=first_name,
                last_name=last_name,
                external_email=external_email,
                is_registered=False,
                is_staff=True
            )

        except IntegrityError:
            logger.warning("Attempted to create new user that appears to already exist: {}".format(email_login))
            return (ReturnCodes.ERR_USER_EXISTS, err_msg_template.format(
                "User exists already", first_name, last_name, email_login))

        try:
            prof = Professor.objects.get(user=newUser)

            prof.phone = phone

            if file != None:
                prof.photo.save(file.name, file)

            prof.save()

        except MultipleObjectsReturned:
            logger.warning("Found multiple professors for the same user={}".format(newUser))

        logger.info("Created new professor with email={}".format(email_login))

        return (ReturnCodes.OK, success_msg_template.format(first_name, last_name, email_login))

    def processNewStudent(self, student, file):
        err_msg_template = "[FAIL] {} - [first_name={}, last_name={}, email_login={}]"
        success_msg_template = "[PASS] Created student - [first_name={}, last_name={}, email_login={}]"

        first_name = student['firstName']
        last_name = student['lastName']
        email_login = student['emailLogin']
        program = int(student['program'])
        external_email = student['externalEmail']
        phone = student['phone']
        specialization = int(student['specialization'])
        intake_season = student['intakeSeason']
        intake_year = int(student['intakeYear'])
        country = student['country']

        # Ensure all required data is there first
        if first_name == "" or last_name == "":
            logger.error("Attempted to add student with no name")
            return (ReturnCodes.ERR_INVALID_FIELD, err_msg_template.format(
                "Name empty", first_name, last_name, email_login))

        if email_login == "":
            logger.error("Attempted to add student with no primary email")
            return (ReturnCodes.ERR_INVALID_FIELD, err_msg_template.format(
                "Email empty", first_name, last_name, email_login))

        if program == "":
            logger.error("Attempted to add student with no program")
            return (ReturnCodes.ERR_INVALID_FIELD, err_msg_template.format(
                "Program empty", first_name, last_name, email_login))

        if specialization == Student.NONE and not program == Student.GITM:
            logger.error("Attempted to add student with no specialization")
            return (ReturnCodes.ERR_INVALID_FIELD, err_msg_template.format(
                "Specialization empty", first_name, last_name, email_login))

        try:
            newUser = User.objects.create_user(
                email=email_login,
                password="epita",
                first_name=first_name,
                last_name=last_name,
                external_email=external_email
            )

        except IntegrityError:
            logger.warning("Attempted to create new user that appears to already exist: {}".format(email_login))
            return (ReturnCodes.ERR_USER_EXISTS, err_msg_template.format(
                "User exists already", first_name, last_name, email_login))

        try:
            student = Student.objects.get(user=newUser)

            student.phone = phone
            student.country = country
            student.program = program
            student.specialization = specialization
            student.intake_season = intake_season
            student.intake_year = intake_year

            if file != "":
                student.photo.save(file.name, file.file)

            student.save()

        except MultipleObjectsReturned:
            logger.warning("Found multiple students for the same user={}".format(newUser))

        logger.info("Created new student with email={}".format(email_login))

        return (ReturnCodes.OK, success_msg_template.format(first_name, last_name, email_login))

    def programStringToValue(self, program):
        programLower = program.lower()
        gitm_options = [str(Student.FGITM), "gitm", "global it management", "fgitm", "french global it management", "french gitm"]
        me_options = [str(Student.ME), "me", "master of engineering", "masters of engineering"]
        msc_options = [str(Student.MSc), "msc", "master of science", "masters of science"]

        if programLower in gitm_options:
            return Student.FGITM

        if programLower in me_options:
            return Student.ME

        if programLower in msc_options:
            return Student.MSc

        return Student.NONE

    def specializationStringToValue(self, specialization):
        specializationLower = specialization.lower()

        none_options = [str(Student.NONE), "", "none"]
        se_options = [str(Student.SE), "se", "software", "software engineering"]
        ism_options = [str(Student.ISM), "ism", "information systems management"]
        dsa_options = [str(Student.DSA), "dsa", "data science", "data science and analytics", "data science & analytics"]
        cs_options = [str(Student.CS), "cs", "security", "computer security"]
        sdm_options = [str(Student.SDM), "sdm", "software development and multimedia", "software development & multimedia"]
        sds_options = [str(Student.SDS), "sds", "software networks & security", "software networks and security"]

        if specializationLower in none_options:
            return Student.NONE

        if specializationLower in se_options:
            return Student.SE

        if specializationLower in ism_options:
            return Student.ISM

        if specializationLower in dsa_options:
            return Student.DSA

        if specializationLower in cs_options:
            return Student.CS

        if specializationLower in sdm_options:
            return Student.SDM

        if specializationLower in sds_options:
            return Student.SDS

        return Student.NONE


class GenerateResetToken(View):
    def post(self, request, *args, **kwargs):
        email = request.POST.get('email')
        user = None
        token = None
        template_name = "reset/password_reset_email_nouser.html"

        try:
            user = User.objects.get(email=email)
        except:
            logger.info("Requested password reset for an email that doesn't exist: {}".format(email))

        if user:
            # Delete all existing tokens for the specific user
            ResetToken.objects.filter(user=user).delete()

            # Generate new token and calculate the expiration date
            token = get_random_string(length=128)
            expiration = timezone.now() + timezone.timedelta(days=1)

            # Add this new token to the database
            reset_token = ResetToken.objects.create(user=user, token=token, expiration=expiration)
            logger.info("Created a password reset token for user: {} that expires at {}".format(
                reset_token.user, reset_token.expiration
            ))

            template_name = "reset/password_reset_email.html"



        # Send email here
        subject = "EPITA password reset request"
        from_email = settings.EMAIL_HOST_USER
        d = {"token": token, "domain": request.get_host(), "protocol": "http"}
        html_template = get_template(template_name)
        html_content = html_template.render(d)
        msg = EmailMultiAlternatives(subject, render_to_string(template_name, d), from_email, [email])
        msg.attach_alternative(html_content, "text/html")
        msg.send()

        return render(request, 'reset/reset_link_sent.html', {'email': email})

    def get(self, request, token, *args, **kwargs):
        return bad_request(request, exception="Forbidden")


class ResetPassword(View):
    def post(self, request, token, *args, **kwargs):
        try:
            reset_token = ResetToken.objects.get(token=token)
        except (ResetToken.DoesNotExist, MultipleObjectsReturned):
            return render(request, 'reset/reset_password.html', {'validlink': False}, status=400)

        form = ResetPasswordForm(request.POST)
        if form.is_valid():
            logger.info("Reset password form for {} was valid, saving new password".format(reset_token.user.email))
            form.save(user=reset_token.user)
            return redirect('home')

        return render(request, 'reset/reset_password.html', {'form': form, 'user': reset_token.user, 'validlink': True})

    def get(self, request, token, *args, **kwargs):
        try:
            reset_token = ResetToken.objects.get(token=token)
        except (ResetToken.DoesNotExist, MultipleObjectsReturned):
            return render(request, 'reset/reset_password.html', {'validlink': False}, status=400)

        if reset_token.expired():
            return render(request, 'reset/reset_password.html', {'validlink': False}, status=403)

        form = ResetPasswordForm()

        return render(request, 'reset/reset_password.html', {'form': form, 'user': reset_token.user, 'validlink': True})