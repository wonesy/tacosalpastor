from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.template import RequestContext
from django.views.generic import ListView
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule
from django.http import JsonResponse
from jchart import Chart
from random import randint
from django.views.generic import TemplateView
from chartjs.views.lines import BaseLineChartView
from django.contrib.auth import get_user_model
from django.views.generic import View
from rest_framework.views import APIView
from rest_framework.response import Response
import csv
from chartit import DataPool, Chart
from django.db.models import Count


@login_required()
def home(request):
    return render(request, 'base_generic.html')


class CourseList(ListView):
    model = Course


class ScheduleList(ListView):

    def get(self, request):
        specific_course = request.GET.get('course_id', '')
        schedules = Schedule.objects.filter(course_id=specific_course)
        specific_course = Course.objects.get(id=specific_course)
        return render(request, 'epita/schedule_list.html', {'schedule_list': schedules, 'course': specific_course})


class AttendanceList(ListView):
class AttendanceList(ListView):
    model = Attendance

    def get(self, request):
        course_time = request.GET.get('schedule_id', '')
        times = Attendance.objects.filter(schedule_id=course_time)
        course_time = Attendance.objects.get(id=course_time)
        return render(request, 'epita/attendance_list.html', {'times': times, 'course_time': course_time})


@login_required()
def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)


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

    countryy = Student.objects.distinct('country')

    a = list(Student.objects.values('country').distinct())
    b = Student.objects.values_list('country')

    c = b.distinct()
    # c1 = Student.objects.filter(country=country).values('country', flat=True).distinct()

    country = Student.objects.order_by('country').values_list('country', flat=True).distinct()
    print(country)

    count = Student.objects.annotate(numb=Count('country'))
    print(count)
    print(count[0].numb)

    return render(request, 'dashboardex.html', {'people_dict': people_dict, 'country': country, 'a': a, 'b': b, 'c': c})
