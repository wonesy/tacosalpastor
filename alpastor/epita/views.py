from django.shortcuts import redirect, get_object_or_404, render
from django.contrib.auth.decorators import login_required
from django.http import QueryDict
from django.views.generic import ListView
from rest_framework.exceptions import bad_request
from .forms import AttendanceForm, ScheduleForm, AccountUpdateForm
from .serializers import AttendanceSerializer
from rest_framework import generics
import json
from django.http import HttpResponse, JsonResponse
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


class AttendanceGraphs(ListView):
    template_name = 'epita/graphs.html'
    form_class = AttendanceForm

    def get(self, request, *args):
        student = 'Willy0'
        course = 'Advanced C Programming'
        intake = 'Fall 2017'
        semester = 'Fall 2019'
        email = 'me_student0@epita.fr'
        professor = 'John'
        specialization = Student.SE
        # all_data = self.whole_semester_by_student_by_class(email, course)
        # all_data = self.whole_semester_by_specialization(semester, specialization)
        all_data = self.default_graph_by_program(semester)
        # all_data = self.whole_semester_by_class(course, semester)
        # all_data = self.individual_student_allclass(student)
        all_data = self.individual_professor_allclass(professor)
        # all_data = self.individual_professor_allclass_by_semester(professor, semester)
        # all_data_json = json.dumps(all_data)
        # return render(request, self.template_name, {'all_data': all_data_json})
        return JsonResponse(all_data)

    def build_attendance_results(self, attendance_list):
        present = 0
        absent = 0
        excused = 0

        for i in attendance_list:
            if i['status'] == Attendance.PRESENT:
                present += 1
            elif i['status'] == Attendance.ABSENT:
                absent += 1
            elif i['status'] == Attendance.EXCUSED:
                excused += 1
        return {'present': present, 'absent': absent, 'excused': excused}

    def default_graph_by_program(self, semester):
        programs = Student.PROGRAM_CHOICES
        program_list = []
        specialization_list = []
        course_list = []

        for program in programs:
            attendances = list(Attendance.objects.filter(student_id__program=program[0],
                                                         schedule_id__course_id__semester=semester).values('status'))
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['program'] = program[1]
            program_list.append(attendance_results)
        for specialization in Student.SPECIALIZATION_CHOICES:
            specialization_list.append(specialization[1])
        for course in Course.objects.filter(semester=semester):
            print(course.title)
            course_list.append(course.title)

        attendance_data = {
            "semester": semester,
            "attendance": program_list,
            "specialization": specialization_list,
            "course": course_list
        }

        return attendance_data

    def whole_semester_by_specialization(self, semester, specialization_val):
        specialization_name = Student.SPECIALIZATION_CHOICES[specialization_val][1]
        courses = Course.objects.values('title').distinct()
        course_list = []

        for course in courses:
            attendances = list(Attendance.objects.filter(schedule_id__course_id__title=course['title'],
                                                         schedule_id__course_id__semester=semester).values('status'))
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['title'] = course['title']
            course_list.append(attendance_results)

        attendance_data = {'specialization': specialization_name, 'courses': course_list}

        return attendance_data

    def whole_semester_by_class(self, course, semester):
        schedule = Schedule.objects.filter(course_id__title=course, course_id__semester=semester)
        attendance_list = []

        for i in schedule:
            attendances = Attendance.objects.filter(schedule_id__date=i.date).values('status')
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['date'] = i.date

            attendance_list.append(attendance_results)
        attendance_data = {'course': course, 'semester': semester, 'attendance': attendance_list}
        return attendance_data

    def whole_semester_by_student_by_class(self, email, course):
        attendance = Attendance.objects.filter(student_id__user__email=email, schedule_id__course_id__title=course)
        student_name = Student.objects.filter(user__email=email)[0].user.get_full_name()
        attendance_data = {'name': student_name, 'course': course,'attendance': []}

        for i in attendance:
            attendance_data['attendance'].append({'date': i.schedule_id.date, 'status': i.status})

        return attendance_data

    def individual_student_allclass(self, name):
        student = Student.objects.filter(user__first_name=name)[0]
        allcourse = StudentCourse.objects.filter(student_id__user__first_name=name)
        student_name = student.user.get_full_name()
        attendance_data = {'name': student_name, 'student': []}
        for y in range(len(allcourse)):
            b = Attendance.objects.filter(student_id__user__first_name=name,
                                          schedule_id__course_id__title=allcourse[y].course_id).values(
                'status').annotate(status_count=Count('status'))
            status_list = list(b)
            attendance_data['student'].append({'course': allcourse[y].course_id.title, 'status': status_list})
        return attendance_data

    def individual_student_allclass(self, name):

        student = Student.objects.filter(user__first_name=name)[0]
        allcourse = StudentCourse.objects.filter(student_id__user__first_name=name)
        # print(allcourse)
        stdname = student.user.get_full_name()
        status = Attendance.objects.filter(student_id__user__first_name=name,
                                           schedule_id__course_id__title=allcourse[0].course_id).values('status')
        # print(status)

        attendance_data = {'name': stdname, 'student': []}

        for y in range(len(allcourse)):
            b = Attendance.objects.filter(student_id__user__first_name=name,
                                          schedule_id__course_id__title=allcourse[y].course_id).values('status')

            print(b)
            attendance_data['student'].append({'course': allcourse[y].course_id.title, 'st': b})
            # attendance_data['student'].append({'st': b})
        # print(attendance_data)

        # attendance_data['student'].append({'allcourse': allcourse})
        # attendance_data['student'][0]['allcourse'] = []
        #
        # for x in allcourse:
        #     attendance_data['student'].append({'course': x.course_id.title})
        #
        # print(x)
        # print(attendance_data)
        #
        # for i in student:
        #     attendance_data['student'][0]['allcourse'].append({'status': i.status})
        #     print('attendace data')
        #     print(attendance_data)
        return attendance_data


    def individual_professor_allclass_by_semester(self, name, semester):
        professor = Professor.objects.filter(user__first_name=name)[0]
        # print(professor)
        courses = Course.objects.filter(professor_id__user__first_name=name).distinct()
        print(courses)
        # course_attendance1 = Attendance.objects.filter(schedule_id__course_id__professor_id__user__first_name=name,
        #                                               schedule_id__course_id__title=courses[0]).values(
        #     'status').annotate(status_count=Count('status'))
        # print(course_attendance1)
        # course_attendance = Attendance.objects.filter(schedule_id__course_id__professor_id__user__first_name=name,
        #                                               schedule_id__course_id__title=courses[1]).values(
        #     'status').annotate(status_count=Count('status'))
        # print(course_attendance)
        professor_name = professor.user.get_full_name()
        p_attendance_data = {'name': professor_name, 'professor': []}
        # print(p_attendance_data)
        for x in range(len(courses)):
            course_attendance = Attendance.objects.filter(schedule_id__course_id__professor_id__user__first_name=name,
                                                          schedule_id__course_id__semester=semester,
                                                          schedule_id__course_id__title=courses[x]).values(
                'status')
            s_list = list(course_attendance)
            p_attendance_data['professor'].append({'course': courses[x].title, 'status': s_list})
            return p_attendance_data

    def individual_professor_allclass(self, name):
        professor = Professor.objects.filter(user__first_name=name)[0]
        course = 'Advanced C Programming'
        courses = Course.objects.filter(professor_id__user__first_name=name, title=course)
        print(courses)
        semester_attendance = Attendance.objects.filter(schedule_id__course_id__semester=courses[1].semester).values(
            'status').annotate(status_count=Count('status'))
        print(semester_attendance)
        professor_name = professor.user.get_full_name()
        p_attendance_data = {'name': professor_name, 'course name': course, 'professor': []}
        for x in range(len(courses)):
            semester_attendance = Attendance.objects.filter(
                schedule_id__course_id__semester=courses[x].semester).values(
                'status').annotate(status_count=Count('status'))
            s_list = list(semester_attendance)
            print("printing s_list")
            print(s_list)
            p_attendance_data['professor'].append({'course semester': courses[1].semester, 'status': s_list})
            return p_attendance_data


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
        schedule_list = Schedule.objects.filter(course_id=course).order_by('date', 'start_time')

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
                admin_emails = User.objects.filter(is_superuser=True).values_list('email')
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
    form_class = AccountUpdateForm

    def get(self, request, *args, **kwargs):
        logged_in_user = request.user
        student_instance = Student.objects.filter(user_id=logged_in_user.id)[0]
        data = {}
        print(student_instance.user)
        print(student_instance.user.email)
        print(student_instance.user.external_email)
        form = self.form_class(instance=student_instance)
        data['student'] = student_instance
        data['form'] = form

        return render(request, self.template_name, data)

    def post(self, request, **kwargs):
        logged_in_user = request.user
        student_instance = Student.objects.filter(user_id=logged_in_user.id)[0]
        data = {}

        instance = get_object_or_404(Student, pk=request.POST['id'])
        form = self.form_class(request.POST, instance=instance)

        data['student'] = student_instance
        data['form'] = form

        return render(request, self.template_name, data)

