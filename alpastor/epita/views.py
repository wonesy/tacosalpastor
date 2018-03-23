from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.template import RequestContext
from django.views.generic import ListView, DetailView
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule


@login_required()
def home(request):
    return render(request, 'base_generic.html')


class CourseList(ListView):
    model = Course

    def post(self, request):
        course_objects = Course.objects.all()
        return render(request, {'course_objects': course_objects})

    # def get(self):
    #     return render()

class ScheduleList(ListView):
    model = Schedule

    def get(self, request):
        specific_course = request.GET.get('course_id','')
        schedules = Schedule.objects.filter(course_id=specific_course)
        specific_course = Course.objects.get(id=specific_course)
        return render(request, 'epita/schedule_list.html', {'schedule_list': schedules, 'course': specific_course})


class AttendanceDetail(ListView):
    model = Attendance

    # def get(self, request):
    #     students_in_course = request.GET.get('')


@login_required()
def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)