from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.template import RequestContext

from django.views.generic import ListView, DetailView, View
from django.views.generic import ListView
from django.http import HttpResponse
from .models import Student, Course, Attendance, Schedule


def home(request):
    return render(request, 'base_generic.html')


class CourseList(ListView):
    model = Course


class ScheduleList(ListView):

    def get(self, request):
        specific_course = request.GET.get('course_id')
        schedules = Schedule.objects.filter(course_id=specific_course)
        return render(request, 'epita/schedule_list.html', {'schedule_list': schedules})


class AttendanceList(ListView):

    def get(self, request):
        course_time = request.GET.get('schedule_id')
        times = Attendance.objects.filter(schedule_id=course_time)
        return render(request, 'epita/attendance_list.html', {'times': times})


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)

#@login_required()
class QuizBuilderView(View):
    template_name = "quiz_builder.html"
    model = Course

    def post(self, request):
        pass

    def get(self, request):
        return render(request, "quiz_builder.html")

    def get_queryset(self):
        return Course.objects.all()
