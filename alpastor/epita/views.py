from django.shortcuts import render
from django.views.generic import ListView
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule


# Create your views here.
def home(request):
    return render(request, 'base_generic.html')


class ScheduleList(ListView):
    model = Schedule


class AttendanceList(ListView):
    model = Attendance


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)