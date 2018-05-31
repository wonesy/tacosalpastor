from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import QueryDict, HttpResponseBadRequest, HttpResponse
from django.views.generic import ListView, View

from rest_framework.exceptions import bad_request

from .forms import AttendanceForm, ScheduleForm
from .serializers import AttendanceSerializer
from rest_framework import generics

import json
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule

from django.views.generic import View

from rest_framework.response import Response
from django.db.models import Count

@login_required()
def home(request):
    return render(request, 'base_generic.html')

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
    template_name = 'epita/schedule_student.html'
    form_class = ScheduleForm

    def get(self, request, slug, **kwargs):
        logged_in_user = request.user
        schedule_list = Schedule.objects.filter(course_id__slug=slug).order_by('date', 'start_time')
        if not logged_in_user.is_staff and not logged_in_user.is_superuser:
            return render(request, self.template_name, {'course': slug, 'schedule_list': schedule_list})

        else:
            self.template_name = 'epita/schedule_prof.html'
            form = self.form_class()
            args = {'course': slug, 'schedule_list': schedule_list, 'form': form}
            return render(request, self.template_name, args)

    def post(self, request, **kwargs):
        form = self.form_class(request.POST)
        if form.is_valid():
            form.save()

        return render(request, self.template_name, {'form': form})



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
            data['form'] = form

        return render(request, self.template_name, data)

    def post(self, request):
        schedule_id = request.GET.get('schedule_id', )
        schedule_instance = Schedule.objects.get(pk=schedule_id)

        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
        file = ""

        if form.is_valid():

            # Do not let the user update attendance information if the schedule instance is marked as closed
            if schedule_instance.attendance_closed and not request.user.is_staff:
                if form.cleaned_data['status'] != Attendance.EXCUSED:
                    print("Cannot update attendance")
            else:
                form.save()
                file = form.cleaned_data['file_upload']
        args = {'form': form, 'file': file}
        return render(request, self.template_name, args)

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

        for student in attendance_json:
            Attendance.objects.filter(schedule_id=schedule_id, student_id=student['id']).update(status=student['status'])
            print("Updated status: " + student['name'] + " --> " + str(student['status']))

        response = redirect('update_attendance', slug=slug)
        response['Location'] += '?schedule_id=' + schedule_id
        return response

class ToggleAttendanceLock(View):

    def get(self, request):
        return bad_request(request, exception="Forbidden")

    def post(self, request, slug):
        # Only professors and admin can change this
        if not (request.user.is_staff or request.user.is_superuser):
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

# def export_to_excel(request):
#
#     lists = Student.objects.all()
#
#     # your excel html format
#     template_name = "people.html"
#
#     response = render(template_name, {'lists': lists})
#
#     # this is the output file
#     filename = "model.csv"
#
#     response['Content-Disposition'] = 'attachment; filename='+filename
#     response['Content-Type'] = 'application/vnd.ms-excel; charset=utf-16'
#     return response


def dashboard(request):
    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students
    # bar graph by country
    country = Student.objects.order_by('country').values_list('country', flat=True).distinct()
    print(country)

    vaar2 = Student.objects.values('country').annotate(the_count=Count('country')).order_by('country')
    print(vaar2)
    # bar graph by program
    program = Student.objects.values('program').annotate(count_program=Count('program')).order_by('program')
    print(program)

    # bar graph by specialization
    splgraph = Student.objects.values('specialization').annotate(count_specialization=Count('specialization')).order_by(
        'specialization')

    # bar graph by year
    return render(request, 'dashboardex.html',
                  {'country': country, 'vaar2': vaar2, 'program': program, 'splgraph': splgraph})

