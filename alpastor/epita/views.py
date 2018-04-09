from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.views.generic import ListView
from .models import Student, Course, Attendance, Schedule
from .forms import AttendanceForm



def home(request):
    return render(request, 'base_generic.html')


class CourseList(ListView):
    print('model:\n')
    model = Course
    for i in Course.objects.all():
        print(i)


class ScheduleList(ListView):

    def get(self, request):
        print('request:\n' + str(request))
        specific_course = request.GET.get('course_id','')
        print("\nspecific_course = request.GET.get('course_id'):\n" + specific_course)
        schedules = Schedule.objects.filter(course_id=specific_course)
        print('\nschedules = Schedule.objects.filter(course_id=specific_course):\n' + str(schedules))
        print("\nrender(request, 'epita/schedule_list.html', {'schedule_list': schedules}):\n" + str(render(request, 'epita/schedule_list.html', {'schedule_list': schedules})))
        return render(request, 'epita/schedule_list.html', {'schedule_list': schedules})


class AttendanceList(ListView):
    template_name = 'epita/attendance_list.html'
    form_class = AttendanceForm

    def get(self, request):
        course_num = request.GET.get('schedule_id','')
        attendance_objects = Attendance.objects.filter(schedule_id=course_num)
        form_list = []
        for i in attendance_objects:
            form = AttendanceForm(instance=i)
            form_list.append(form)
        return render(request, self.template_name, {'form_list': form_list})


    def post(self, request):
        form = AttendanceForm(request.POST)
        if form.is_valid():
            form.save()

        course_num = request.GET.get('schedule_id','')
        attendance_objects = Attendance.objects.filter(schedule_id=course_num)
        form_list = []
        for i in attendance_objects:
            form = AttendanceForm(instance=i)
            form_list.append(form)
            print(form)
        print(form_list)
        return render(request, self.template_name, {'form_list': form_list})

        # course_num = request.GET.get('schedule_id','')
        # print("\n\n\nSTART OF POST\n\n\ncourse_num = request.POST.get('schedule_id',''):\n" +  str(request.GET.get('schedule_id','')))
        # print(course_num)
        # print('\nrequest' + str(request))
        # form = self.form_class(request.POST)#, request.FILES)
        # # print(request.FILES)
        # print('\nform = self.form_class(request.POST, request.FILES):\n' + str(form))
        # if form.is_valid():
        #     form.save()
            # file = form.cleaned_data['file_upload']
            # print('\nfile:\n' + str(file))
        # args = {'form': form, 'file':file}
        # print('\nargs:\n' + str(args))
        # print('\nrender(request, self.template_name, args):\n' + str(render(request, self.template_name, args)))
        # return render(request, self.template_name, {'form': form})


def people(request):

    people_dict = {}

    active_students = Student.objects.all()

    people_dict['students'] = active_students

    return render(request, 'people.html', people_dict)