from epita.models import *
from datetime import date
from django.utils import timezone

# course = Course.objects.filter(id=1) # Advanced C Programming
course_name = input("Enter course name or partial name to filter by: ")
course = Course.objects.filter(title__contains=course_name)
# course = Course.objects.filter(id=2) # Management Somthing or other


month = input("Enter month as number to create class schedules: ")
# Every month has at least 28 days
first_schedule_id = 0
for i in range(1, 28):
    if i == 1:
        first_schedule_id = Schedule.objects.create(course_id=course[0], date=date(2019, month, i), start_time=timezone.now(), end_time=timezone.now())
    else:
        # Creates courses with date of Fall 2019
        Schedule.objects.create(course_id=course[0], date=date(2019, month, i), start_time=timezone.now(), end_time=timezone.now())

# Get students from specialization
specialization = input("Enter specialization number from models (integer): ")
all_students_of_specialization = Student.objects.filter(specialization=specialization)

# Get lowest student.id to know where to start increments in next loop
get_min = []
[get_min.append(i.id) for i in all_students_of_specialization]
first_student_id = min(get_min)

# number of students to change status
for i in range(num_of_students.count()):
    for j in range(28): # Number of scheduled days to adjust (Every month has at least 28 days)
        Attendance.objects.filter(schedule_id=first_schedule_id.id + j, student_id=i+ first_student_id).update(status=1)
