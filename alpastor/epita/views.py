from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.generic import ListView
from .models import Student, Course, Attendance, Schedule
from .forms import AttendanceForm



def home(request):
    return render(request, 'base_generic.html')

################################################
# Professor View for attendance module         #
################################################

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


################################################
# Student View for attendance module           #
################################################

class CourseStudentView(ListView):
    template_name = 'epita/course_list_student.html'
    student_num = 4

    def get(self, request):
        student_instance = self.student_num
        user_courses = Attendance.objects.filter(student_id__user_id=student_instance)
        return render(request, self.template_name, {'user_courses' : user_courses})


class ScheduleStudentView(ListView):
    template_name = 'epita/schedule_list_student.html'

    def get(self, request):
        course_instance = request.GET.get('course_id', '')
        selected = Attendance.objects.get(id=course_instance)
        schedule_list = Schedule.objects.filter(course_id=selected.schedule_id.course_id)
        return render(request, self.template_name, {'schedule_list' : schedule_list})


class AttendanceStudentView(ListView):
    pass


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)