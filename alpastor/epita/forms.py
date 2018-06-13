from django.utils import timezone
from datetime import datetime
from epita.models import Student

from django import forms
from .models import Attendance, Schedule, Course

class AttendanceForm(forms.ModelForm):

    class Meta:
        model = Attendance
        fields = ['id', 'status', 'schedule_id', 'student_id', 'file_upload']
        widgets = {
            'upload_time': forms.HiddenInput()
        }


class ScheduleForm(forms.ModelForm):

    class Meta:
        model = Schedule
        fields = ['id', 'course_id', 'date', 'start_time', 'end_time', 'attendance_closed']
        widgets = {
            # 'date': forms.DateField(initial=timezone.now() + timezone.timedelta(hours=2)),
            # 'start_time': datetime.now(),
            # 'start_time': forms.TimeField(initial=timezone.now()),
            'attendance_closed': forms.HiddenInput()
        }

class CourseForm(forms.ModelForm):
    class Meta:
        model = Course
        fields = ['professor_id', 'code', 'title', 'description', 'semester', 'module', 'credits']
        widgets = {
            'credits': forms.NumberInput(attrs={'min': 0}),
            'semester': forms.TextInput(attrs={'pattern': "(Fall|Spring|Summer|Winter) \d{4}"}),
        }
        labels = {
            'assign_program': "Assign this course to students of the following\nProgram"
        }

    def __init__(self, *args, **kwargs):
        super(CourseForm, self).__init__(*args, **kwargs)
        self.fields['professor_id'].label = "Professor"
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'
            visible.field.widget.attrs['placeholder'] = visible.field.help_text
            visible.field.help_text = None


class AssignStudentCourseForm(forms.Form):
    program = forms.ChoiceField(choices=Student.PROGRAM_CHOICES)
    specialization = forms.ChoiceField(choices=Student.SPECIALIZATION_CHOICES)
    semester = forms.CharField(max_length=31)

    widgets = {
        'semester': forms.TextInput(attrs={'pattern': "(Fall|Spring|Summer|Winter) \d{4}"}),
    }

    def __init__(self, *args, **kwargs):
        super(AssignStudentCourseForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'