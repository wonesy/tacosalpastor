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
        semester = 'Fall 2017'
        # all_data = self.individual_student_class_dates(student, course)
        all_data = self.whole_class(course, semester)
        # return render(request, self.template_name, {'all_data': all_data})
        return JsonResponse(all_data)

    def whole_class(self, course, semester):
        attendance = Attendance.objects.filter(schedule_id__course_id__title=course)
        course_id = attendance[0].schedule_id.course_id
        students = Student.objects.filter(studentcourse__course_id=course_id)
        attendance_data = {'course': course, 'semester': semester, 'student': []}
        count = 0
        for student in students:
            attendance_data['student'].append({'name': student.user.get_full_name()})
            attendance_data['student'][count]['attendance'] = []
            student_id = student.id
            student_attendance = Attendance.objects.filter(student_id=student_id, schedule_id__course_id=course_id)
            for i in student_attendance:
                attendance_data['student'][count]['attendance'].append({'date': i.schedule_id.date, 'status': i.status})
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


class CourseView(ListView):
    template_name = 'epita/course_list.html'

    def get(self, request, **kwargs):
        user_instance = request.user

        if user_instance.is_superuser:
            course_list = Course.objects.all().order_by('title')

        elif user_instance.is_staff:
            course_list = Course.objects.filter(professor_id__user_id=user_instance).order_by('title')

        else:
            course_list = []
            enrolled_in = StudentCourse.objects.filter(student_id__user_id=user_instance).select_related('course_id')
            [course_list.append(course.course_id) for course in enrolled_in]

        return render(request, self.template_name, {'course_list': course_list})


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
                course_queryset = Course.objects.all()
            else:
                course_queryset = Course.objects.filter(professor_id__user=request.user)

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
            data['form'] = form

        return render(request, self.template_name, data)

    def post(self, request, slug, **kwargs):
        schedule_id = request.GET.get('schedule_id', )
        schedule_instance = Schedule.objects.get(pk=schedule_id)

        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
        file = ""

        if form.is_valid():
            # Do not let the user update attendance information if the schedule instance is marked as closed
            if (schedule_instance.attendance_closed) and (not request.user.is_staff) and (form.cleaned_data['status'] != Attendance.EXCUSED):
                logger.warning("Student attempting to change attendance status for a locked schedule")
            else:
                form.save()
                file = form.cleaned_data['file_upload']
        args = {'form': form, 'file': file}
        url = reverse('schedule_list', kwargs={'slug': slug})

        return redirect(url)


@login_required()
def people(request):
    people_dict = {}

    active_students = Student.objects.all()

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
    print(country)
    # bar graph by program
    program = Student.objects.values('program').annotate(count_program=Count('program')).order_by('program')
    print(program)
    print(program.count())

    # bar graph by specialization
    splgraph = Student.objects.values('specialization').annotate(count_specialization=Count('specialization')).order_by(
        'specialization')

    # bar graph by intake semester
    intakeSemester = Student.objects.values('intakeSemester').annotate(count_intake=Count('intakeSemester')).order_by(
        'intakeSemester')
    print(intakeSemester)

    return render(request, 'dashboardex.html',
                  {'country': country, 'program': program, 'splgraph': splgraph, 'active_students': active_students,
                   'intakeSemester': intakeSemester})