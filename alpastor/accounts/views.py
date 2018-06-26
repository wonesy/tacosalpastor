from django.core.exceptions import MultipleObjectsReturned
from django.db import IntegrityError
from django.shortcuts import render, redirect
from django.contrib.auth import logout
from django.contrib.auth import login as auth_login
from django.contrib.auth.decorators import user_passes_test
from accounts.forms import LoginForm, ResetPasswordForm
from accounts.models import User, ResetToken
from epita.models import Student
from epita.forms import CourseForm
from rest_framework import generics
from rest_framework.exceptions import bad_request
from django.http import HttpResponseRedirect, JsonResponse, QueryDict
from django.views.generic import View
from django.utils.crypto import get_random_string
from django.utils import timezone
import json
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
    return render(request, 'accounts/manage_users.html', {
        'programs': Student.PROGRAM_CHOICES,
        'specializations': Student.SPECIALIZATION_CHOICES,
        'course_form': course_form
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
        override_intakeSemester = request.POST.get('overrideIntakeSemester')
        override_country = request.POST.get('overrideCountry')

        for line in lines[1:]:
            user = {
                'first_name': "",
                'last_name': "",
                'program': "",
                'specialization': "",
                'intakeSemester': "",
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
                user['intakeSemester'] = fields[self.csv_positions['intake_semester']]

            if user['intakeSemester'] == "" and override_intakeSemester != None:
                user['intakeSemester'] = override_intakeSemester

            all_users.append(user)

        logger.info("Processing CSV user file with {} potential users".format(len(all_users)))

        return JsonResponse(all_users, safe=False)

class SaveNewUsers(View):
    def get(self, request, *args, **kwargs):
        return bad_request(request, exception="Forbidden")

    def post(self, request, *args, **kwargs):
        users_json = QueryDict(request.body).get('users')
        users = json.loads(users_json)

        response_code = 200
        response_messages = []

        for user in users:
            if user['isProfessor'] == True:
                (rc, msg) = self.processNewProfessor(user)
            else:
                (rc, msg) = self.processNewStudent(user)

            response_messages.append(msg)
            if rc != ReturnCodes.OK:
                response_code = 400

        return JsonResponse(status=response_code, data={'messages': response_messages})

    def processNewProfessor(self, professor):
        return (ReturnCodes.OK, "OK")

    def processNewStudent(self, student):
        err_msg_template = "[FAIL] {} - [first_name={}, last_name={}, email_login={}]"
        success_msg_template = "[PASS] Created student - [first_name={}, last_name={}, email_login={}]"

        first_name = (student['firstName'])
        last_name = student['lastName']
        email_login = student['emailLogin']
        program = self.programStringToValue(student['program'])
        external_email = student['externalEmail']
        phone = student['phone']
        pic = student['pic']
        specialization = self.specializationStringToValue(student['specialization'])
        intake_semester = student['intakeSemester']
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
            Student.objects.filter(user=newUser).update(
                phone=phone,
                country=country,
                program=program,
                specialization=specialization,
                intakeSemester=intake_semester
            )
        except MultipleObjectsReturned:
            logger.warning("Found multiple students for the same user={}".format(newUser))
            Student.objects.filter(user=newUser)[0].update(
                phone=phone,
                country=country,
                program=int(program),
                specialization=specialization,
                intakeSemester=intake_semester
            )

        logger.info("Created new student with email={}".format(email_login))

        return (ReturnCodes.OK, success_msg_template.format(first_name, last_name, email_login))

    def programStringToValue(self, program):
        programLower = program.lower()
        gitm_options = [str(Student.GITM), "gitm", "global it management"]
        me_options = [str(Student.ME), "me", "master of engineering", "masters of engineering"]
        msc_options = [str(Student.MSc), "msc", "master of science", "masters of science"]

        if programLower in gitm_options:
            return Student.GITM

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

        try:
            user = User.objects.get(email=email)
        except:
            logger.info("Requested password reset for an email that doesn't exist: {}".format(email))
            return render(request, 'reset/reset_link_sent.html', {'email': email})

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

        return render(request, 'reset/reset_link_sent.html', {'email': email})

    def get(self, request, token, *args, **kwargs):
        return bad_request(request, exception="Forbidden")

class ResetPassword(View):
    def post(self, request, token, *args, **kwargs):
        try:
            reset_token = ResetToken.objects.get(token=token)
        except (ResetToken.DoesNotExist, MultipleObjectsReturned):
            return render(request, 'reset/reset_password.html', {'validlink': False})

        form = ResetPasswordForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('home')
        return render(request, 'reset/reset_password.html', {'form': form, 'user': reset_token.user, 'validlink': True})

    def get(self, request, token, *args, **kwargs):
        try:
            reset_token = ResetToken.objects.get(token=token)
        except (ResetToken.DoesNotExist, MultipleObjectsReturned):
            return render(request, 'reset/reset_password.html', {'validlink': False})

        if reset_token.expired():
            return render(request, 'reset/reset_password.html', {'validlink': False})

        form = ResetPasswordForm()

        return render(request, 'reset/reset_password.html', {'form': form, 'user': reset_token.user, 'validlink': True})