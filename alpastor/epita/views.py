from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.generic import ListView
from .models import Student, Course, Attendance, Schedule, StudentCourse
from .forms import AttendanceForm
from .serializers import AttendanceSerializer
from rest_framework import generics
from rest_framework.response import Response


def home(request):
    return render(request, 'base_generic.html')

# @login_required
class CourseView(ListView):
    template_name = 'epita/course_list.html'

    def get(self, request, **kwargs):
        user_instance = request.user

        if user_instance.is_superuser:
            course_list = Course.objects.all().order_by(
                'title').values_list('title', flat=True).distinct()

        elif user_instance.is_staff:
            course_list = Course.objects.filter(professor_id__user_id=user_instance).order_by(
                'title').values_list('title', flat=True).distinct()

        else:
            course_list = StudentCourse.objects.filter(student_id__user_id=user_instance).order_by(
                'course_id__title').values_list('course_id__title', flat=True).distinct()

        return render(request, self.template_name, {'course_list': course_list})

class ScheduleView(ListView):
    template_name = 'epita/schedule_list.html'

    def get(self, request, **kwargs):
        course_instance = request.GET.get('course_name', )
        schedule_list = Schedule.objects.filter(course_id__title=course_instance)
        return render(request, self.template_name, {'schedule_list': schedule_list})

class AttendanceView(ListView):
    template_name = 'epita/attendance_list.html'
    form_class = AttendanceForm

    def get(self, request, *args, **kwargs):
        schedule_instance = request.GET.get('schedule_id', )
        user_instance = request.user

        # Error immediately if no such schedule_id exists
        _ = get_object_or_404(Schedule, pk=schedule_instance)

        if user_instance.is_staff or user_instance.is_superuser:
            self.template_name = 'epita/attendance_prof.html'
            attendance_objects = Attendance.objects.filter(schedule_id=schedule_instance).order_by(
                'student_id__user__first_name')
            print(attendance_objects)
            form_list = []
            for i in attendance_objects:
                form = self.form_class(instance=i)
                form_list.append(form)
            form = form_list


        else:
            self.template_name = 'epita/attendance_student.html'
            attendance_instance, created = Attendance.objects.get_or_create(
                student_id=Student.objects.get(user_id=user_instance.id),
                defaults = {
                    'schedule_id': Schedule.objects.get(id=schedule_instance),
                }
            )

            form = self.form_class(instance=attendance_instance)

        return render(request, self.template_name, {'form': form})

    def post(self, request):
        instance = get_object_or_404(Attendance, pk=request.POST['id'])
        form = self.form_class(request.POST, request.FILES, instance=instance)
        schedule_instance = request.GET.get('schedule_id', )
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

class GetStudentAttendanceData(generics.ListCreateAPIView):
    serializer_class = AttendanceSerializer
    queryset = Attendance.objects.all()

    def get(self, request, **kwargs):
        attendance = self.get_queryset()
        serializers = AttendanceSerializer(attendance, many=True)
        return Response(serializers.data)

    def get_queryset(self):
        schedule_filter = self.request.query_params.get('schedule_id', )

        if schedule_filter == None:
            return None

        queryset = Attendance.objects.filter(schedule_id=schedule_filter)

        return queryset

    def perform_create(self, serializer):
        """ Save the POST data """
        serializer.save()