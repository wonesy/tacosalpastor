from django import forms
from .models import Attendance, Schedule

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