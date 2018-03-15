from django.shortcuts import render
from django.http import HttpResponse
from .models import Student
from .models import Professor
from .models import StudentCourse


# Create your views here.
def home(request):
    return render(request, 'base_generic.html')


def attendance(request):

    course_dict = {}

    active_courses = StudentCourse.objects.all()

    course_dict['courses'] = active_courses

    return render(request, 'attendance.html', course_dict)


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)