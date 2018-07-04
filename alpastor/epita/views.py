from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import QueryDict
from django.views.generic import ListView
from rest_framework.exceptions import bad_request
from .forms import AttendanceForm, ScheduleForm
from .serializers import AttendanceSerializer
from rest_framework import generics
import json
from django.http import HttpResponse, JsonResponse
from .models import Student, StudentCourse, Course, Attendance, Schedule
from django.views.generic import View
from rest_framework.response import Response
from django.db.models import Count
from django.urls import reverse

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
        semester = 'Fall 2017'
        # all_data = self.individual_student_class_dates(student, course)
        # all_data = self.whole_class(course, semester)
        # all_data = self.whole_semester(semester, intake)
        all_data = self.individual_student_allclass(student)
        # return render(request, self.template_name, {'all_data': all_data})
        return JsonResponse(all_data)

        # PROGRAM_CHOICES = [
        #     (0, 'None'),
        #     (1, 'Master of Engineering'),
        #     (2, 'Master of Science'),
        #     (3, 'Global IT Management (French)'),
        #     (4, "Exchange")
        # ]
        #
        # SPECIALIZATION_CHOICES = [
        #     (0, 'None'),
        #     (1, 'Software Engineering'),
        #     (2, 'Information Systems Management'),
        #     (3, 'Data Science & Analytics'),
        #     (4, 'Computer Security'),
        #     (5, 'Software Development & Multimedia'),
        #     (6, 'Systems Networks & Security'),
        #     (7, 'Global IT Management (International)')

    def whole_semester(self, semester, intake):
        attendance_data = {'intake': intake, 'semester': semester, 'programs': []}
        programs_tuple = Student.PROGRAM_CHOICES
        specializations_tuple = Student.SPECIALIZATION_CHOICES
        me_specializations = []
        msc_specializations = []
        no_specialization = [{'specialization': 'None'}]
        for i in range(len(programs_tuple)):
            if programs_tuple[i][1] == 'Master of Engineering':
                for j in range(len(specializations_tuple)):
                    if (specializations_tuple[j][1] == 'Software Development & Multimedia'
                            or specializations_tuple[j][1] == 'Systems Networks & Security'
                            or specializations_tuple[j][1] == 'Global IT Management (International)'):
                        me_specializations.append({'specialization': specializations_tuple[j][1]})
            if programs_tuple[i][1] == 'Master of Science':
                for j in range(len(specializations_tuple)):
                    if (specializations_tuple[j][1] == 'Software Engineering'
                            or specializations_tuple[j][1] == 'Information Systems Management'
                            or specializations_tuple[j][1] == 'Data Science & Analytics'
                            or specializations_tuple[j][1] == 'Computer Security'):
                        msc_specializations.append({'specialization': specializations_tuple[j][1]})

        for program in programs_tuple:
            if program[1] not in attendance_data['programs']:
                if program[1] == 'Master of Engineering':
                    attendance_data['programs'].append({'program': program[1], 'specializations': me_specializations})
                elif program[1] == 'Master of Science':
                    attendance_data['programs'].append({'program': program[1], 'specializations': msc_specializations})
                else:
                    attendance_data['programs'].append({'program': program[1], 'specializations': no_specialization})

        no_specialization = Student.objects.filter(program=Student.NONE, intakeSemester=intake)

        me_students = Student.objects.filter(program=Student.ME, intakeSemester=intake)
        msc_students = Student.objects.filter(program=Student.MSc, intakeSemester=intake)
        gitm_students = Student.objects.filter(program=Student.FGITM, intakeSemester=intake)
        exchange_students = Student.objects.filter(program=Student.EXCHANGE, intakeSemester=intake)
        Attendance.objects.filter(schedule_id__course_id__semester=semester)
        print(msc_students)
        return attendance_data

    def whole_class(self, course, semester):
        attendance = Attendance.objects.filter(schedule_id__course_id__title=course)
        course_id = attendance[0].schedule_id.course_id
        students = Student.objects.filter(studentcourse__course_id=course_id)
        attendance_data = {'course': course, 'semester': semester, 'students': []}
        count = 0
        for student in students:
            attendance_data['students'].append({'name': student.user.get_full_name()})
            attendance_data['students'][count]['attendance'] = []
            student_id = student.id
            student_attendance = Attendance.objects.filter(student_id=student_id, schedule_id__course_id=course_id)
            for i in student_attendance:
                attendance_data['students'][count]['attendance'].append({'date': i.schedule_id.date, 'status': i.status})
            count += 1
        return attendance_data

    def individual_student_class_dates(self, name, course):
        attendance = Attendance.objects.filter(student_id__user__first_name=name, schedule_id__course_id__title=course)
        student = Student.objects.filter(user__first_name=name)[0]
        student_name = student.user.get_full_name()
        attendance_data = {'student': []}
        attendance_data['student'].append({'name': student_name})
        attendance_data['student'][0]['course'] = attendance[0].schedule_id.course_id.title
        attendance_data['student'][0]['attendance'] = []
        for i in attendance:
            attendance_data['student'][0]['attendance'].append({'date': i.schedule_id.date, 'status': i.status})
        print(attendance_data)
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




class CourseView(ListView):
    template_name = 'epita/course_list.html'

    def get(self, request, **kwargs):
        user_instance = request.user

        courses_by_semester = {}

        if user_instance.is_superuser:
            semesters = Course.objects.values_list('semester_season', 'semester_year').distinct().order_by('-semester_year', '-semester_season')
            for semester in semesters:
                courses_by_semester[self.season_to_string(semester[0]) + " " + str(semester[1])] = Course.objects.filter(
                    semester_season=semester[0], semester_year=semester[1]).order_by('title')

        elif user_instance.is_staff:
            semesters = Course.objects.filter(professor_id__user_id=user_instance).values_list(
                'semester_season', 'semester_year').distinct().order_by('-semester_year', '-semester_season')
            for semester in semesters:
                courses_by_semester[self.season_to_string(semester[0]) + " " + str(semester[1])] = Course.objects.filter(
                    semester_season=semester[0], semester_year=semester[1], professor_id__user_id=user_instance).order_by('title')

        else:
            enrolled_in = StudentCourse.objects.filter(student_id__user_id=user_instance).select_related('course_id').order_by(
                '-course_id__semester_year', '-course_id__semester_season'
            )
            for course in enrolled_in:
                key = self.season_to_string(course.course_id.semester_season) + " " + str(course.course_id.semester_year)
                if not key in courses_by_semester:
                    courses_by_semester[key] = Course.objects.filter(semester_season=course.course_id.semester_season,
                            semester_year=course.course_id.semester_year,
                            title=course.course_id.title
                    )

        return render(request, self.template_name, {'semester_list': courses_by_semester})

    def season_to_string(self, season_int):
        return [x[1] for x in Student.SEASON_CHOICES][season_int]


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

        if instance.schedule_id.attendance_closed:
            return redirect('schedule_list', slug=slug)

        status = request.POST.get('status')
        file_upload = request.POST.get('file_upload')
        user = request.user



        if not status:
            return redirect('schedule_list', slug=slug)

        if (status == str(Attendance.EXCUSED)) and not file_upload:
            return redirect('schedule_list', slug=slug)

        Attendance.objects.filter(schedule_id_id=schedule_id, student_id__user=user).update(
            status=status,
            file_upload=file_upload
        )

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


def dashboard(request):
    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    # bar graph by country

    country = Student.objects.values('country').annotate(the_count=Count('country')).order_by('country')

    program_list = []
    program = Student.objects.values('program').annotate(count_program=Count('program')).order_by('program')
    for p in program:
        program_strings = {}
        program_strings['program'] = Student.program_to_string(None, p['program'])
        program_strings['count_program'] = p['count_program']
        program_list.append(program_strings)

    # bar graph by specialization

    specialization_list = []
    specialization = Student.objects.values('specialization').annotate(
        count_specialization=Count('specialization')).order_by('specialization')
    for s in specialization:
        specialization_strings = {}
        specialization_strings['specialization'] = Student.specialization_to_string(None, s['specialization'])
        specialization_strings['count_specialization'] = s['count_specialization']
        specialization_list.append(specialization_strings)


    semesters = Student.objects.values('intake_season', 'intake_year').order_by('intake_year', 'intake_season').distinct()
    for s in semesters:
        s['count'] = Student.objects.filter(intake_season=s['intake_season'], intake_year=s['intake_year']).count()
        s['intake_season'] = Student.season_to_string(None, s['intake_season'])

    return render(request, 'dashboardex.html',
                  {'country': country, 'program': program_list, 'splgraph': specialization_list, 'active_students': active_students,
                   'intakeSemester': semesters})
