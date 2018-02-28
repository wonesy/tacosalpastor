from django.shortcuts import render
from django.http import HttpResponse
from .models import Student
from .models import Professor


# Create your views here.
def home(request):
    return render(request, 'base_generic.html')

def people(request):
    activeStudents = Student.object.all()

    return HttpResponse()
