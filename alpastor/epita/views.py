from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.template import RequestContext
from django.views.generic import ListView, DetailView
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule


def home(request):
    return render(request, 'base_generic.html')


class CourseList(ListView):
    model = Course


class ScheduleList(ListView):

    def get(self, request):
        specific_course = request.GET.get('course_id','')
        schedules = Schedule.objects.filter(course_id=specific_course)
        specific_course = Course.objects.get(id=specific_course)
        return render(request, 'epita/schedule_list.html', {'schedule_list': schedules, 'course': specific_course})


class AttendanceList(ListView):

    def get(self, request):
        course_time = request.GET.get('schedule_id','')
        times = Attendance.objects.filter(schedule_id=course_time)
        course_time = Attendance.objects.get(id=course_time)
        return render(request, 'epita/attendance_list.html', {'times': times, 'course_time': course_time})


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)