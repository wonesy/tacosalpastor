from django import forms
from .models import Attendance

class AttendanceForm(forms.ModelForm):

    class Meta:
        model = Attendance
        fields = ['id', 'schedule_id', 'student_id', 'status', 'file_upload']
        widgets = {
            'status' : forms.RadioSelect(choices=Attendance.ATTENDANCE_CHOICES),
            'upload_time' : forms.HiddenInput(),
        }
