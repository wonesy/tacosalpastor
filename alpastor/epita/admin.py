from django.contrib import admin
from .models import *

class CourseAdmin(admin.ModelAdmin):
    list_display = ('title', 'semester_season', 'semester_year')
admin.site.register(Course, CourseAdmin)

class StudentAdmin(admin.ModelAdmin):
    list_display = ('user', 'student_email', 'intake_season', 'intake_year')
admin.site.register(Student, StudentAdmin)

class ProfessorAdmin(admin.ModelAdmin):
    list_display = ('user', 'professor_email')
admin.site.register(Professor, ProfessorAdmin)

class StudentCourseAdmin(admin.ModelAdmin):
    list_display = ('student_id', 'course_id')
admin.site.register(StudentCourse, StudentCourseAdmin)


admin.site.register(Schedule)
admin.site.register(Attendance)