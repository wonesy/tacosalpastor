from django import forms
from .models import Attendance

class AttendanceForm(forms.ModelForm):

    class Meta:
        model = Attendance
        fields = ['student_id', 'status', 'file_upload']
        widgets = {
            'status' : forms.RadioSelect(choices=Attendance.ATTENDANCE_CHOICES),
            'schedule_id' : forms.HiddenInput(),
            'upload_time' : forms.HiddenInput()
        }
