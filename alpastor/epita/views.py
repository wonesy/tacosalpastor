from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.generic import ListView
from .models import Student, Course, Attendance, Schedule
from .forms import AttendanceForm



def home(request):
    return render(request, 'base_generic.html')


class CourseList(ListView):
    model = Course


class ScheduleList(ListView):

    def get(self, request):
        specific_course = request.GET.get('course_id','')
        schedules = Schedule.objects.filter(course_id=specific_course)
        return render(request, 'epita/schedule_list.html', {'schedule_list': schedules})


class AttendanceList(ListView):
    template_name = 'epita/attendance_list.html'
    form_class = AttendanceForm

    def get(self, request):
        course_num = request.GET.get('schedule_id','')
        attendance_objects = Attendance.objects.filter(schedule_id=course_num)
        form_list = []
        for i in attendance_objects:
            form = self.form_class(instance=i)
            form_list.append(form)
        return render(request, self.template_name, {'form_list': form_list})


    def post(self, request, *args, **kwargs):
        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
        if form.is_valid():
            form.save()
            file = form.cleaned_data['file_upload']
        args = {'form': form, 'file':file}
        return render(request, self.template_name, args)


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)