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
from epita import views
from epita.views import AttendanceList, ScheduleList

# add new URL to this structure in alpastor/urls.py
urlpatterns = [
    path('', views.home, name='home'),
    path('attendance/', ScheduleList.as_view(), name='schedule'),
    path('attendance/student-list/', AttendanceList.as_view(), name='attendance'),
    path('people/', views.people, name='people'),
    path('admin/', admin.site.urls),
]
