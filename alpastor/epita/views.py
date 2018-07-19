from django.shortcuts import redirect, get_object_or_404, render
from django.contrib.auth.decorators import login_required
from django.http import QueryDict
from django.views.generic import ListView
from django.views.defaults import page_not_found
from rest_framework.exceptions import bad_request
from .forms import AttendanceForm, ScheduleForm, AccountUpdateForm, ProfessorAccountUpdateForm, UserAccountUpdateForm
from .serializers import AttendanceSerializer
from rest_framework import generics
import json
import hashlib
import os
from django.http import HttpResponse
from .models import Student, StudentCourse, Course, Attendance, Schedule, Professor, choice_to_string
from django.views.generic import View
from rest_framework.response import Response
from django.db.models import Count
from alpastor import settings
from django.template.loader import get_template, render_to_string
from django.core.mail import EmailMultiAlternatives
from accounts.models import User
from django_countries import countries


import logging

logger = logging.getLogger(__name__)

@login_required()
def home(request):
    return render(request, 'base_generic.html')

class CourseView(ListView):
    template_name = 'epita/course_list.html'

    def get(self, request, **kwargs):
        user_instance = request.user

        courses_by_semester = {}

        if user_instance.is_superuser:
            semesters = Course.objects.values_list('semester_season', 'semester_year').distinct().order_by('-semester_year', '-semester_season')
            for semester in semesters:
                courses_by_semester[choice_to_string(Student.SEASON_CHOICES, semester[0]) + " " + str(semester[1])] = Course.objects.filter(
                    semester_season=semester[0], semester_year=semester[1]).order_by('title')

        elif user_instance.is_staff:
            semesters = Course.objects.filter(professor_id__user_id=user_instance).values_list(
                'semester_season', 'semester_year').distinct().order_by('-semester_year', '-semester_season')
            for semester in semesters:
                courses_by_semester[choice_to_string(Student.SEASON_CHOICES, semester[0]) + " " + str(semester[1])] = Course.objects.filter(
                    semester_season=semester[0], semester_year=semester[1], professor_id__user_id=user_instance).order_by('title')

        else:
            enrolled_in = StudentCourse.objects.filter(student_id__user_id=user_instance).select_related('course_id').order_by(
                '-course_id__semester_year', '-course_id__semester_season'
            )
            for course in enrolled_in:
                key = choice_to_string(Student.SEASON_CHOICES, course.course_id.semester_season) + " " + str(course.course_id.semester_year)
                if not key in courses_by_semester:
                    courses_by_semester[key] = Course.objects.filter(semester_season=course.course_id.semester_season,
                            semester_year=course.course_id.semester_year,
                            title=course.course_id.title
                    )

        return render(request, self.template_name, {'semester_list': courses_by_semester})

class ScheduleView(ListView):
    template_name = 'epita/schedule_prof.html'
    form_class = ScheduleForm

    def get(self, request, slug):
        logged_in_user = request.user
        course = get_object_or_404(Course, slug=slug)
        schedule_list = Schedule.objects.filter(course_id__slug=slug).order_by('date', 'start_time')

        # Student view
        if not logged_in_user.is_staff and not logged_in_user.is_superuser:
            self.template_name = 'epita/schedule_student.html'

            schedule_data = []

            for schedule in schedule_list:
                attendance = Attendance.objects.get(schedule_id=schedule, student_id__user=request.user)
                schedule_data.append({'schedule': schedule, 'attendance': attendance})

            return render(request, self.template_name, {
                'course': course,
                'schedule_data': schedule_data,
                'total': schedule_list.count(),
                'numPresent': Attendance.objects.filter(schedule_id__course_id=course, student_id__user=request.user, status=Attendance.PRESENT).count()
            })

        # Professor/Admin View
        else:
            if request.user.is_superuser:
                course_queryset = Course.objects.all().order_by('-semester_year', '-semester_season')
            else:
                course_queryset = Course.objects.filter(professor_id__user=request.user).order_by('-semester_year', '-semester_season')

            form = self.form_class()
            form.fields['course_id'].queryset = course_queryset
            form.fields['course_id'].initial = course

            args = {'course': course, 'schedule_list': schedule_list, 'form': form}
            return render(request, self.template_name, args)

    def post(self, request, slug):
        course = get_object_or_404(Course, slug=slug)
        form = self.form_class(request.POST)
        if form.is_valid():
            form.save()
        schedule_list = Schedule.objects.filter(course_id__slug=slug).order_by('date', 'start_time')
        args = {
            'course': course,
            'schedule_list': schedule_list,
            'form': form
        }
        return render(request, self.template_name, args)


class AttendanceView(ListView):
    template_name = 'epita/attendance_list.html'
    form_class = AttendanceForm

    def get(self, request, *args, **kwargs):
        schedule_id = request.GET.get('schedule_id', )
        logged_in_user = request.user
        data = {}

        # Error immediately if no such schedule_id exists
        _ = get_object_or_404(Schedule, pk=schedule_id)

        if logged_in_user.is_staff or logged_in_user.is_superuser:
            self.template_name = 'epita/attendance_prof.html'
            schedule_instance = Schedule.objects.get(pk=schedule_id)
            data['schedule'] = schedule_instance

        else:
            self.template_name = 'epita/attendance_student.html'
            student_instance = Student.objects.get(user_id=logged_in_user.id)
            schedule_instance = Schedule.objects.get(pk=schedule_id)
            attendance_instance, created = Attendance.objects.get_or_create(
                student_id=student_instance,
                schedule_id=schedule_instance
            )

            form = self.form_class(instance=attendance_instance)
            data['attendance'] = attendance_instance
            data['student'] = student_instance
            data['form'] = form

        return render(request, self.template_name, data)

    def post(self, request, slug, **kwargs):

        schedule_id = request.GET.get('schedule_id')

        instance = get_object_or_404(Attendance, schedule_id=schedule_id,
                                     student_id__user=request.user)

        status = request.POST.get('status')
        user = request.user

        try:
            file_upload = request.FILES['file_upload']
        except:
            file_upload = None

        # Only changes to EXCUSED state are accepted after the attendance is closed
        if (instance.schedule_id.attendance_closed) and (status != str(Attendance.EXCUSED)):
            return redirect('schedule_list', slug=slug)

        # There must be a status to change for there to be anything saved
        if not status:
            return redirect('schedule_list', slug=slug)

        # If the change is to EXCUSED, there must be an accompanying document
        if (status == str(Attendance.EXCUSED)) and not file_upload:
            return redirect('schedule_list', slug=slug)

        form = AttendanceForm(instance=instance, data=request.POST, files=request.FILES)
        if form.is_valid():
            logger.info("Updating attendance information: {} now marked as {}".format(user.get_full_name(), status))
            saved_instance = form.save()

            if file_upload and status == str(Attendance.EXCUSED):
                template_name = 'attendance/excuse_doc_email.html'
                admin = User.objects.filter(is_superuser=True)
                admin_emails = [x.email for x in admin]

                # Send email here
                subject = "EPITA attendance excuse document uploaded"
                from_email = settings.EMAIL_HOST_USER
                d = {
                    "doc_url": saved_instance.file_upload.url,
                    "domain": request.get_host(),
                    "protocol": "http",
                    "attendance": instance
                }
                html_template = get_template(template_name)
                html_content = html_template.render(d)
                msg = EmailMultiAlternatives(subject, render_to_string(template_name, d), from_email, admin_emails)
                msg.attach_alternative(html_content, "text/html")
                msg.send()
        else:
            logger.info("Failed up update attendance information")

        return redirect('schedule_list', slug=slug)


@login_required()
def people(request):
    people_dict = {}

    active_students = Student.objects.filter(user__is_active=True).order_by(
        'intake_year', 'intake_season', 'program', 'specialization', 'user__last_name')
    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)


class GetStudentAttendanceData(generics.ListCreateAPIView):
    '''
    This class view is solely responsible for delivering JSON-formatted data on the updated attendance information
    for a particular schedule instance

    Serializers are simply fancy names for turning python model data (database queries) into JSON serialized data
    '''
    serializer_class = AttendanceSerializer
    queryset = Attendance.objects.all()

    def get(self, request, **kwargs):
        attendance = self.get_queryset()
        serializers = AttendanceSerializer(attendance, many=True)
        return Response(serializers.data)

    def get_queryset(self):
        '''
        Queries database for all attendance records for a given schedule ID

        :return: queryset of all attendance records for a particular schedule_id, received from HTTP GET
        '''
        schedule_filter = self.request.query_params.get('schedule_id', )

        if schedule_filter == None:
            return None

        queryset = Attendance.objects.filter(schedule_id=schedule_filter)

        return queryset

    def perform_create(self, serializer):
        """ Save the POST data """
        serializer.save()


class OverrideStudentAttendanceData(View):
    def get(self, request, **kwargs):
        return bad_request(request, exception="Forbidden")

    def post(self, request, slug):

        # Only available to staff/admin
        if not (request.user.is_staff or request.user.is_superuser):
            return bad_request(request, exception="Forbidden")

        schedule_id = QueryDict(request.body).get('schedule_id')

        # This is because testing comes in from a different way, django doesn't support ajax that well
        if schedule_id == None:
            schedule_id = request.POST.get('schedule_id')

        attendance_payload = QueryDict(request.body).get('students')

        # This is because testing comes in from a different way, django doesn't support ajax that well
        if attendance_payload == None:
            attendance_payload = request.POST.get('students')

        attendance_json = json.loads(attendance_payload)

        # Update the status
        for student in attendance_json:
            Attendance.objects.filter(schedule_id=schedule_id, student_id=student['id']).update(status=student['status'])

        # Send back the json serialized data of all students, now that the update has gone through
        response = redirect('update_attendance', slug=slug)
        response['Location'] += '?schedule_id=' + schedule_id
        return response

class ToggleAttendanceLock(View):

    def get(self, request):
        logger.error("Attempting get request for toggle attendance lock")
        return bad_request(request, exception="Forbidden")

    def post(self, request, slug):
        # Only professors and admin can change this
        if not (request.user.is_staff or request.user.is_superuser):
            logger.warning("Attempting to unlock a schedule as a student (user_id={})".format(request.user.id))
            return bad_request(request, exception="Forbidden")

        # Grab POST data
        schedule_id = QueryDict(request.body).get('schedule_id')
        lock_status_payload = QueryDict(request.body).get('lock_status')
        lock_status_json = json.loads(lock_status_payload)

        # Find particular schedule
        schedule = Schedule.objects.filter(id=schedule_id)

        # Update lock status
        if schedule.count() > 0:
            schedule.update(attendance_closed=lock_status_json)

        return HttpResponse(200)

@login_required()
def dashboard(request):
    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    # bar graph by country

    sem = '2018'
    # bar graph by country

    country = Student.objects.values('country').annotate(the_count=Count('country')).order_by('country')

    new = Student.objects.filter(intake_year=sem).values('country').annotate(the_count=Count('country')).order_by(
        'country')
    # print(new)

    semesters = Student.objects.values_list('intake_season', 'intake_year').distinct().order_by('-intake_season',
                                                                                                '-intake_year')
    # print(semesters)

    country_by_semester = {}

    for semester in semesters:
        country_by_semester[choice_to_string(Student.SEASON_CHOICES, semester[0]) + " " + str(
            semester[1])] = Student.objects.filter(intake_season=semester[0], intake_year=semester[1]).values(
            'country').annotate(the_count=Count('country')).order_by('country')

    country = Student.objects.values('country').annotate(the_count=Count('country')).order_by('country')

    country_dict = dict(countries)
    for c in country:
        c['country_name'] = country_dict[c['country']]

    program_list = []
    program = Student.objects.values('program').annotate(count_program=Count('program')).order_by('program')
    for p in program:
        program_strings = {}
        program_strings['program'] = choice_to_string(Student.PROGRAM_CHOICES, p['program'])
        program_strings['count_program'] = p['count_program']
        program_list.append(program_strings)

    # bar graph by specialization

    specialization_list = []
    specialization = Student.objects.values('specialization').annotate(
        count_specialization=Count('specialization')).order_by('specialization')
    for s in specialization:
        specialization_strings = {}
        specialization_strings['specialization'] = choice_to_string(Student.SPECIALIZATION_CHOICES, s['specialization'])
        specialization_strings['count_specialization'] = s['count_specialization']
        specialization_list.append(specialization_strings)


    semesters = Student.objects.values('intake_season', 'intake_year').order_by('intake_year', 'intake_season').distinct()
    for s in semesters:
        s['count'] = Student.objects.filter(intake_season=s['intake_season'], intake_year=s['intake_year']).count()
        s['intake_season'] = choice_to_string(Student.SEASON_CHOICES, s['intake_season'])

    return render(request, 'dashboard.html',
                  {'country': country, 'program': program_list, 'splgraph': specialization_list, 'active_students': active_students,
                    'intakeSemester': semesters, 'countrysemester': country_by_semester})


class AccountUpdateView(ListView):
    template_name = 'epita/accounts.html'

    def get(self, request, *args, **kwargs):
        logged_in_user = request.user
        data = {}
        if logged_in_user.is_staff and not logged_in_user.is_superuser:
            professor_instance = Professor.objects.get(user_id=logged_in_user.id)
            data['professor'] = professor_instance
            data['form'] = ProfessorAccountUpdateForm(instance=professor_instance)
        elif logged_in_user.is_superuser:
            superuser_instance = User.objects.get(id=logged_in_user.id)
            data['professor'] = superuser_instance
            data['form'] = UserAccountUpdateForm(instance=superuser_instance)
        else:
            student_instance = Student.objects.get(user_id=logged_in_user.id)
            data['student'] = student_instance
            data['form'] = AccountUpdateForm(instance=student_instance)

        return render(request, self.template_name, data)

    def post(self, request, **kwargs):
        logged_in_user = request.user
        data = {}
        if logged_in_user.is_staff and not logged_in_user.is_superuser:
            instance = get_object_or_404(Professor, user=logged_in_user)
            form = ProfessorAccountUpdateForm(data=request.POST, files=request.FILES, instance=instance)
            if form.is_valid():
                form.save()
            data['professor'] = instance
            data['form'] = form
        elif logged_in_user.is_superuser:
            instance = get_object_or_404(User, pk=logged_in_user.id)
            form = UserAccountUpdateForm(data=request.POST, files=request.FILES, instance=instance)
            if form.is_valid():
                form.save()
            data['professor'] = instance
            data['form'] = form
        else:
            instance = get_object_or_404(Student, user=logged_in_user)
            form = AccountUpdateForm(data=request.POST, files=request.FILES, instance=instance)
            if form.is_valid():
                form.save()
            data['student'] = instance
            data['form'] = form
        return render(request, self.template_name, data)

@login_required()
def CheckAttendanceByUser(request, slug, token):
    schedule_id = request.GET.get('schedule_id', None)

    if not schedule_id:
        return page_not_found(request, "Bad Request")

    lock = int(os.getenv('LOCK'), 16)
    x = ""
    while (lock):
        x += chr(lock & 0xff)
        lock = lock >> 8

    y = x + request.user.email + slug
    if (token == str(hashlib.sha256(y.encode('utf-8')).hexdigest())):
        Attendance.objects.filter(student_id__user=request.user, schedule_id_id=schedule_id).update(status=Attendance.PRESENT)
    else:
        return page_not_found(request, "Bad Request")

    return redirect('home')