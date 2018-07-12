from django.utils import timezone
from datetime import datetime
from epita.models import Student
from epita.models import Student as UpdateStudent
from epita.models import Professor as UpdateProfessor
from accounts.models import User


from django import forms
from django.forms import ValidationError
from .models import Attendance, Schedule, Course


class CourseSelect(forms.ModelChoiceField):
    def label_from_instance(self, obj):
        return obj.verbose_title()


class AttendanceForm(forms.ModelForm):
    class Meta:
        model = Attendance
        fields = ['status', 'schedule_id', 'student_id', 'file_upload']


class ScheduleForm(forms.ModelForm):
    class Meta:
        model = Schedule
        fields = ['id', 'course_id', 'date', 'start_time', 'end_time', 'attendance_closed']
        widgets = {
            'attendance_closed': forms.HiddenInput(),
        }

    def __init__(self, *args, **kwargs):
        super(ScheduleForm, self).__init__(*args, **kwargs)
        self.fields['course_id'] = CourseSelect(queryset=Course.objects.all())
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'

    def clean(self):
        super(ScheduleForm, self).clean()
        start = self.cleaned_data['start_time']
        end = self.cleaned_data['end_time']

        if (start > end):
            raise ValidationError("Start time cannot be after the end time")


class CourseForm(forms.ModelForm):
    class Meta:
        model = Course
        fields = ['professor_id', 'code', 'title', 'description', 'semester_season', 'semester_year', 'module', 'credits']
        widgets = {
            'credits': forms.NumberInput(attrs={'min': 0}),
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
    semester_season = forms.ChoiceField(choices=Student.SEASON_CHOICES)
    semester_year = forms.IntegerField(max_value=timezone.now().year)

    def __init__(self, *args, **kwargs):
        super(AssignStudentCourseForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'


class StudentCourseForm(forms.Form):
    course = CourseSelect(queryset=Course.objects.all())
    program = forms.ChoiceField(choices=Student.PROGRAM_CHOICES)
    specialization = forms.ChoiceField(choices=Student.SPECIALIZATION_CHOICES)
    intake_season = forms.ChoiceField(choices=Student.SEASON_CHOICES)
    intake_year = forms.IntegerField()

    def __init__(self, *args, **kwargs):
        super(StudentCourseForm, self).__init__(*args, **kwargs)
        year = timezone.now().year
        self.fields['course'].queryset = Course.objects.filter(semester_year__gt=year-2).order_by('-semester_year', '-semester_season')
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'


class AccountUpdateForm(forms.ModelForm):
    email = forms.CharField(widget=forms.TextInput(attrs={
                'readonly': True
            }))
    external_email = forms.CharField(widget=forms.TextInput())

    class Meta:
        model = UpdateStudent
        fields = ['phone', 'city',
                  'address_street', 'address_city',
                  'address_misc', 'postal_code']
        widgets = {
            'city': forms.TextInput(attrs={
                'readonly': True
            })
        }

    def __init__(self, *args, **kwargs):
        super(AccountUpdateForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'
        self.fields['email'].initial = self.instance.user.email
        self.fields['external_email'].initial = self.instance.user.external_email
        order_list = ['email', 'external_email', 'phone', 'city',
                      'address_street', 'address_city',
                      'address_misc', 'postal_code']
        # order_list = ['user', 'email', 'phone', 'program', 'specialization', 'intake_season',
        #               'intake_year', 'country',
        #               'city', 'address_street', 'address_city', 'address_misc', 'postal_code',
        #               'dob']
        print(order_list)
        self.order_fields(order_list)
        print(self.instance.user.email)
        # print(self.instance.user.external_email)

    def save(self, commit=True):
        instance = super(AccountUpdateForm, self).save()
        instance.user.external_email = self.cleaned_data['external_email']
        instance.user.save()


class ProfessorAccountUpdateForm(forms.ModelForm):
    email = forms.CharField(widget=forms.TextInput(attrs={
                'readonly': True
            }))
    external_email = forms.CharField(widget=forms.TextInput())

    class Meta:
        model = UpdateProfessor
        fields = ['phone']

    def __init__(self, *args, **kwargs):
        super(ProfessorAccountUpdateForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'
        self.fields['email'].initial = self.instance.user.email
        self.fields['external_email'].initial = self.instance.user.external_email
        order_list = ['email', 'external_email', 'phone']
        # print(order_list)
        self.order_fields(order_list)


class UserAccountUpdateForm(forms.ModelForm):

    class Meta:
        model = User
        fields = ['email', 'external_email', 'title']

        widgets = {
            'email': forms.EmailInput(attrs={
                'readonly': True,
            }),
            'first_name': forms.TextInput(attrs={
                'readonly': True,
            }),
            'last_name': forms.TextInput(attrs={
                'readonly': True,
            })
        }

    def __init__(self, *args, **kwargs):
        super(UserAccountUpdateForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'input-group'
