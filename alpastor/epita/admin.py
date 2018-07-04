from django.contrib import admin
from .models import *

# Register your models here.
admin.site.register(Student)
admin.site.register(Professor)
admin.site.register(Course)
admin.site.register(StudentCourse)
admin.site.register(Schedule)
admin.site.register(Attendance)