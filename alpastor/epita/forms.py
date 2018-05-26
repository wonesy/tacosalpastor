from django import forms
from .models import Attendance

class AttendanceForm(forms.ModelForm):

    class Meta:
        model = Attendance
        fields = ['id', 'status', 'schedule_id', 'student_id', 'file_upload']
        widgets = {
            'upload_time': forms.HiddenInput()
        }
