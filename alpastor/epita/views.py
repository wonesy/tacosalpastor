from django.shortcuts import render
from django.http import HttpResponse
from .models import Student
from .models import Professor


# Create your views here.
def home(request):
    return render(request, 'base_generic.html')

def people(request):

    people_dict = {}

    activeStudents = Student.objects.all()

    people_dict['students'] = activeStudents

    return render(request, 'people.html', people_dict)