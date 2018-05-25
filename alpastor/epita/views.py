from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.views.generic import ListView
from .models import Student, Course, Attendance, Schedule
from .forms import AttendanceForm
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
from django.db.models import Count

@login_required()
def home(request):
    return render(request, 'base_generic.html')


# @login_required
class CourseView(ListView):
    template_name = 'epita/course_list.html'

    def get(self, request):
        user_instance = request.user

        if user_instance.is_superuser:
            course_list = Attendance.objects.all()

        elif user_instance.is_staff:
            course_list = Attendance.objects.filter(schedule_id__course_id__professor_id__user_id=user_instance)

        else:
            course_list = Attendance.objects.filter(student_id__user_id=user_instance)

        course_list = course_list.order_by('schedule_id__course_id__title')
        course_list = course_list.values_list('schedule_id__course_id__title', flat=True).distinct()
        return render(request, self.template_name, {'course_list': course_list})


class ScheduleView(ListView):
    template_name = 'epita/schedule_list.html'

    def get(self, request):
        course_instance = request.GET.get('course_name', '')
        schedule_list = Schedule.objects.filter(course_id__title=course_instance)
        return render(request, self.template_name, {'schedule_list': schedule_list})


class AttendanceView(ListView):
    template_name = 'epita/attendance_list.html'
    form_class = AttendanceForm

    def get(self, request, *args, **kwargs):
        schedule_instance = request.GET.get('schedule_id', '')
        user_instance = request.user

        if user_instance.is_staff or user_instance.is_superuser:
            attendance_objects = Attendance.objects.filter(schedule_id=schedule_instance).order_by(
                'student_id__user__first_name')
            form_list = []
            for i in attendance_objects:
                form = self.form_class(instance=i)
                form_list.append(form)
            form = form_list

        else:
            self.template_name = 'epita/attendance_student'
            attendance_instance = Attendance.objects.filter(student_id__user_id=user_instance).filter(
                schedule_id=schedule_instance)
            form = self.form_class(instance=attendance_instance[0])

        return render(request, self.template_name, {'form': form})

    def post(self, request):
        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
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
    # bar graph by country
    country = Student.objects.order_by('country').values_list('country', flat=True).distinct()
    print(country)

    vaar2 = Student.objects.values('country').annotate(the_count=Count('country')).order_by('country')
    print(vaar2)
    # bar graph by program
    program = Student.objects.values('program').annotate(count_program=Count('program')).order_by('program')
    print(program)

    # bar graph by specialization
    splgraph = Student.objects.values('specialization').annotate(count_specialization=Count('specialization')).order_by(
        'specialization')

    # bar graph by year
    return render(request, 'dashboardex.html',
                  {'country': country, 'vaar2': vaar2, 'program': program, 'splgraph': splgraph})
