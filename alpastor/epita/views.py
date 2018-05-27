from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import QueryDict, HttpResponse
from django.views.generic import ListView, View
from .models import Student, Course, Attendance, Schedule, StudentCourse
from .forms import AttendanceForm
from .serializers import AttendanceSerializer
from rest_framework import generics
from rest_framework.response import Response
import json


def home(request):
    return render(request, 'base_generic.html')

# @login_required
class CourseView(ListView):
    template_name = 'epita/course_list.html'

    def get(self, request, **kwargs):
        user_instance = request.user

        if user_instance.is_superuser:
            course_list = Course.objects.all().order_by(
                'title').values_list('title', flat=True).distinct()

        elif user_instance.is_staff:
            course_list = Course.objects.filter(professor_id__user_id=user_instance).order_by(
                'title').values_list('title', flat=True).distinct()

        else:
            course_list = StudentCourse.objects.filter(student_id__user_id=user_instance).order_by(
                'course_id__title').values_list('course_id__title', flat=True).distinct()

        return render(request, self.template_name, {'course_list': course_list})

class ScheduleView(ListView):
    template_name = 'epita/schedule_list.html'

    def get(self, request, **kwargs):
        course_instance = request.GET.get('course_name', )
        schedule_list = Schedule.objects.filter(course_id__title=course_instance)
        return render(request, self.template_name, {'schedule_list': schedule_list})

class AttendanceView(ListView):
    template_name = 'epita/attendance_list.html'
    form_class = AttendanceForm

    def get(self, request, *args, **kwargs):
        schedule_instance = request.GET.get('schedule_id', )
        logged_in_user = request.user

        # Error immediately if no such schedule_id exists
        _ = get_object_or_404(Schedule, pk=schedule_instance)

        if logged_in_user.is_staff or logged_in_user.is_superuser:
            self.template_name = 'epita/attendance_prof.html'
            attendance_objects = Attendance.objects.filter(schedule_id=schedule_instance).order_by(
                'student_id__user__first_name')
            form_list = []
            for i in attendance_objects:
                form = self.form_class(instance=i)
                form_list.append(form)
            form = form_list


        else:
            student_instance = Student.objects.get(user_id=logged_in_user.id)
            self.template_name = 'epita/attendance_student.html'
            attendance_instance, created = Attendance.objects.get_or_create(
                student_id=student_instance,
                schedule_id=schedule_instance
            )

            form = self.form_class(instance=attendance_instance)

        return render(request, self.template_name, {'form': form})

    def post(self, request):
        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
        schedule_instance = request.GET.get('schedule_id', )
        if form.is_valid():
            form.save()
            file = form.cleaned_data['file_upload']
        args = {'form': form, 'file': file}
        return render(request, self.template_name, args)


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
        pass

    def post(self, request, **kwargs):
        schedule_id = QueryDict(request.body).get('schedule_id')
        attendance_payload = QueryDict(request.body).get('students')
        attendance_json = json.loads(attendance_payload)

        for student in attendance_json:
            Attendance.objects.filter(schedule_id=schedule_id, student_id=student['id']).update(status=student['status'])
            print("Updated status: " + student['name'] + " --> " + str(student['status']))
            return HttpResponse()