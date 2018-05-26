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
from django.contrib import admin
from django.urls import path
from accounts import views as accounts_views
from quiz import views as quiz_views
from epita import views
from epita.views import CourseList, ScheduleList, AttendanceList
from django.conf import settings
from django.conf.urls.static import static
from rest_framework.urlpatterns import format_suffix_patterns




# add new URL to this structure in alpastor/urls.py
urlpatterns = [
    path('', views.home, name='home'),
    path('attendance/', CourseList.as_view(), name='course_list'),
    path('attendance/schedule/', ScheduleList.as_view(), name='schedule_list'),
    path('attendance/schedule/students/', AttendanceList.as_view(), name='attendance_list'),
    path('people/', views.people, name='people'),
    path('login/', accounts_views.login, name='login'),
    path('quizbuilder/', quiz_views.QuizBuilderView.as_view(), name='quizbuilder'),
    path('quizbuilder/savenewquiz/', quiz_views.SaveNewQuiz.as_view(), name='savenewquiz'),
    path('quizbuilder/existingquestion/', quiz_views.AddExistingQuestionView.as_view(), name='existingquestion'),
    path('admin/', admin.site.urls),
    path('quiz/', views.quizHomePage, name='quiz_home_page'),
    path('quiz/edit', views.EditQuizPage.as_view(), name='editquiz'),
   # path('quiz/', views.SearchCourse, name='SearchCourse'),
]

urlpatterns = format_suffix_patterns(urlpatterns)

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATICFILES_DIRS)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
