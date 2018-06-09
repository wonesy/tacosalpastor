from django.utils import timezone
from datetime import datetime

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
