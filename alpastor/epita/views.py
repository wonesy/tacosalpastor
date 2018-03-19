from django.shortcuts import render, get_object_or_404
from django.views.generic import ListView
from django.http import HttpResponse
from .models import Student, Professor, StudentCourse, Course, Attendance, Schedule


# Create your views here.
def home(request):
    return render(request, 'base_generic.html')


class ScheduleList(ListView):
    model = Schedule

    # def get_queryset(self):
    #     self.course_id = get_object_or_404(Schedule, name=self.kwargs['course_id'])
    #     # return Book.objects.filter(course_id=self.course_id)
    #     pass

class AttendanceList(ListView):
    model = Attendance


# class AttendanceStudentClass(ListView):
#     template_name = 'epita/schedule_list.html'
#
#     def get_queryset(self):
#         self.course_id = get_object_or_404(Attendance, schedule_id=self.kwargs['course_id'])
#         return Schedule.objects.filter(course_id=self.course_id)


# class AttendanceSemesterList(ListView):
#     model = Attendance
#     template_name = "epita/attendance_list.html"
#
#     def get_queryset(self):
#         # semester_val =
#         # print(Course.objects.filter(semester=))
#         return Course.objects.filter(semester=self.kwargs['semester'])

# class AttendanceStudentClass(ListView):
#     template_name = 'epita/schedule_list.html'
#
#     def get_queryset(self):
#         return "This worked"

def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)