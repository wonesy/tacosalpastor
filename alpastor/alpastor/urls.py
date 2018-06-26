"""alpastor URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.urls import path
from accounts import views as accounts_views
from quiz import views as quiz_views
from epita import views
from epita.views import CourseView, ScheduleView, AttendanceView, GetStudentAttendanceData, OverrideStudentAttendanceData, ToggleAttendanceLock
from django.conf import settings
from django.conf.urls.static import static
from rest_framework.urlpatterns import format_suffix_patterns
from django.contrib.auth.decorators import login_required

# add new URL to this structure in alpastor/urls.py
urlpatterns = [
    path('', views.home, name='home'),

    # Attendance
    path('attendance/course/<slug:slug>/schedule/update', login_required(GetStudentAttendanceData.as_view()), name='update_attendance'),
    path('attendance/course/<slug:slug>/schedule/manualoverride', login_required(OverrideStudentAttendanceData.as_view()), name='override_attendance'),
    path('attendance/course/<slug:slug>/schedule/togglelock', login_required(ToggleAttendanceLock.as_view()), name='toggle_attendance_lock'),
    path('attendance/course/<slug:slug>/schedule/', login_required(AttendanceView.as_view()), name='attendance_list'),
    path('attendance/course/<slug:slug>', login_required(ScheduleView.as_view()), name='schedule_list'),
    path('attendance/', login_required(CourseView.as_view()), name='course_list'),

    # People
    path('people/', views.people, name='people'),

    # Quiz paths
    path('quiz/quiz_builder/savenewquiz/', login_required(quiz_views.SaveNewQuiz.as_view()), name='savenewquiz'),
    path('quiz/quiz_builder/getquiz/', login_required(quiz_views.GetQuizData.as_view()), name='existingquestion'),
    path('quiz/quiz_builder/', login_required(quiz_views.QuizBuilderView.as_view()), name='quizbuilder'),
    path('quiz/', quiz_views.quizHomePage, name='quiz_home_page'),
    path('quiz/', quiz_views.delete, name='delete_view'),

     # Password Reset
    path('generatereset/', accounts_views.GenerateResetToken.as_view(), name='genreset'),
    path('reset/<str:token>/', accounts_views.ResetPassword.as_view(), name='resetpass'),

    # Admin/Superuser
    path('login/', accounts_views.login, name='login'),
    path('manageusers/processusercsv/', login_required(accounts_views.ProcessUserCSVData.as_view()), name='processusercsv'),
    path('manageusers/savenewusers/', login_required(accounts_views.SaveNewUsers.as_view()), name='savenewusers'),
    path('manageusers/savenewcourse/', login_required(accounts_views.SaveNewCourse.as_view()), name='savenewcourse'),
    path('manageusers/', login_required(accounts_views.manageusers), name='manageusers'),
    path('dashboardex/', views.dashboard, name='dashboardex'),
    path('admin/', admin.site.urls),

]


urlpatterns = format_suffix_patterns(urlpatterns)

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATICFILES_DIRS)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
