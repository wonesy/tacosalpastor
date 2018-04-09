from django import forms
from .models import Attendance

class AttendanceForm(forms.ModelForm):

    class Meta:
        model = Attendance
        fields = ['student_id', 'status', 'schedule_id', 'file_upload', 'upload_time']
        widgets = {
            'status' : forms.RadioSelect(choices=Attendance.ATTENDANCE_CHOICES)
        }
