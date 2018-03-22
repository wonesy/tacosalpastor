from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.template import RequestContext
from django.views.generic import ListView
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule


@login_required()
def home(request):
    return render(request, 'base_generic.html')

class ScheduleList(ListView):
    model = Schedule

class AttendanceList(ListView):
    model = Attendance

@login_required()
def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)