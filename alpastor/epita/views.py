from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.views.generic import ListView
from .models import Student, Course, Attendance, Schedule
from .forms import AttendanceForm



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
            self.template_name = 'epita/attendance_student.html'
            attendance_instance = Attendance.objects.filter(student_id__user_id=user_instance).filter(
                schedule_id=schedule_instance)
            form = self.form_class(instance=attendance_instance[0])

        return render(request, self.template_name, {'form': form})

    def post(self, request):
        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
        schedule_instance = request.GET.get('schedule_id', '')
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