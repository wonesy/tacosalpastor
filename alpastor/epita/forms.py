from django import forms
from .models import Attendance

class AttendanceForm(forms.ModelForm):
    # post = forms.FileField(required=False)
    class Meta:
        model = Attendance
        fields = ['file_upload']
