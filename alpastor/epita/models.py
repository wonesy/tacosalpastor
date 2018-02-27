from django.db import models

# Create your models here.
class Student(models.Model):
    first_name = models.CharField(max_length=127)
    last_name = models.CharField(max_length=127)
    external_email = models.CharField(max_length=255, unique=True)
    epita_email = models.CharField(max_length=255, unique=True)
    phone = models.IntegerField()
    program = models.CharField(max_length=6)
    specialization = models.CharField(max_length=63)
    classof = models.CharField(max_length=31)
    country = models.CharField(max_length=127)
    city = models.CharField(max_length=127)
    languages = models.CharField(max_length=127)
    photo_location = models.CharField(max_length=511)

class Professor(models.Model):
    first_name = models.CharField(max_length=127)
    last_name = models.CharField(max_length=127)
    external_email = models.CharField(max_length=255, unique=True)
    epita_email = models.CharField(max_length=255, unique=True)
    phone = models.IntegerField()

class Course(models.Model):

    class Meta:
        unique_together = (('title', 'semester'),)

    professor_id = models.ForeignKey(Professor, on_delete=models.CASCADE)
    title = models.CharField(max_length=127)
    description = models.TextField(max_length=1000)
    semester = models.CharField(max_length=31)
    module = models.CharField(max_length=63)
    credits = models.IntegerField()

class StudentCourse(models.Model):
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)

class Grades(models.Model):
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)
    assignment = models.CharField(max_length=255)
    points_earned = models.IntegerField()
    points_possible = models.IntegerField()

class Room(models.Model):
    building = models.CharField(max_length=63)
    has_whiteboard = models.BooleanField()
    has_chalkboard = models.BooleanField()
    has_projector = models.BooleanField()
    size = models.IntegerField()

class Schedule(models.Model):
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    date = models.DateField
    start_time = models.TimeField()
    end_time = models.TimeField()
    room_id = models.ForeignKey(Room, on_delete=models.CASCADE)

class Attendance(models.Model):
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)
    schedule_id = models.ForeignKey(Schedule, on_delete=models.CASCADE)
    status = models.IntegerField()



