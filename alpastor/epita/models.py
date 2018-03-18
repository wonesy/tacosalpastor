from django.db import models
import datetime


class Student(models.Model):
    """
    Defines the Student database table

    Args:
        first_name = student's first name (prenom)
        last_name = student's last name (nom)
        external_email = student's non-epita email
        epita_email = student's auto-assigned epita email
        phone = phone number, in string form, to allow international + symbols
        program = student's overall program (ME, MSc)
        specialization = student's sub specialty (Software Engineering, ISM, etc.)
        classof = class that student joined, form of Season Year (Fall 2017, Spring 2016)
        country = country of origin for the student
        city = city of origin for the student
        languages = which languages the student speaks, comma separated (English,French)
        photo_location = path on server to the stored location of the student's photo
    """
    first_name = models.CharField(max_length=127)
    last_name = models.CharField(max_length=127)
    external_email = models.CharField(max_length=255, unique=True)
    epita_email = models.CharField(max_length=255, unique=True)
    phone = models.CharField(max_length=31)
    program = models.CharField(max_length=6)
    specialization = models.CharField(max_length=63)
    classof = models.CharField(max_length=31)
    country = models.CharField(max_length=127)
    country_code = models.CharField(max_length=2)
    city = models.CharField(max_length=127)
    languages = models.CharField(max_length=127)
    photo_location = models.CharField(max_length=511, blank=True)

    def __repr__(self):
        return "Student(first_name={}, last_name={}, external_email={}, epita_email={}, phone={}, program={}, " \
               "specialization={}, classof={}, country={}, country_code={}, city={}, languages={}, photo_location={}" \
               ")".format(self.first_name, self.last_name, self.external_email, self.epita_email, self.phone,
                          self.program, self.specialization, self.classof, self.country, self.country_code, self.city,
                          self.languages, self.photo_location)

    def __str__(self):
        return "{} {}".format(self.first_name, self.last_name)


class Professor(models.Model):
    """
    Defines the Professor database table

    Args:
        first_name = professor's first name (prenom)
        last_name = professor's last name (nom)
        external_email = professor's non-epita email
        epita_email = professor's auto-assigned epita email
        phone = phone number, in string form, to allow international + symbols
    """
    first_name = models.CharField(max_length=127)
    last_name = models.CharField(max_length=127)
    external_email = models.CharField(max_length=255, unique=True)
    epita_email = models.CharField(max_length=255, unique=True)
    phone = models.CharField(max_length=31)

    def __repr__(self):
        return "Professor(first_name={}, last_name={}, external_email={}, epita_email={}, phone={})".format(
            self.first_name, self.last_name, self.external_email, self.epita_email, self.phone)

    def __str__(self):
        return "{} {}".format(self.first_name, self.last_name)


class Course(models.Model):
    """
    Defines the Course database table

    Args:
        professor_id = FK to the Professor table, indicating who is teaching it
        title = title of the course
        description = fuller description of the course
        semester = the semester in which the course will be taught, form Season Year (Spring 2020)
        module = the grading module that this course falls under (Technical, Business, etc)
        credits = the number of credits that will be offered for this course

    Note:
         columns 'title' and 'semester' must be unique as a pair, meaning you cannot have the same course title
         during the same semester
    """
    class Meta:
        unique_together = (('title', 'semester'),)

    professor_id = models.ForeignKey(Professor, on_delete=models.CASCADE)
    title = models.CharField(max_length=127)
    description = models.TextField(max_length=1000)
    semester = models.CharField(max_length=31)
    module = models.CharField(max_length=63)
    credits = models.IntegerField()

    def __repr__(self):
        return "Course(professor_id={}, title={}, description={}, semester={}, module={}, credits={})".format(
            self.professor_id, self.title, self.description, self.semester, self.module, self.credits)

    def __str__(self):
        return " {} by {} ".format(self.title, self.professor_id)


class StudentCourse(models.Model):
    """
    Defines the StudentCourse database table

    This is a table meant to store which classes each student belongs to

    Args:
        course_id = FK to a specific course
        student_id = FK to a specific student
    """
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)

    def __repr__(self):
        return "StudentCourse(course_id={}, student_id={})".format(self.course_id, self.student_id)

    def __str__(self):
        return "{}".format(self.course_id)


class Grades(models.Model):
    """
    Defines the Grades database table

    Args:
        course_id = FK to a specific course
        student_id = FK to a specific student
        assignment = assignment description/title
        points_earned = the number of points a student has earned on this assignment
        points_possible = the number of possible points that could be earned on this assignment
    """
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)
    assignment = models.CharField(max_length=255)
    points_earned = models.IntegerField()
    points_possible = models.IntegerField()

    def __repr__(self):
        return "Grades(course_id={}, student_id={}, assignment={}, points_earned={}, points_possible={})".format(
            self.course_id, self.student_id, self.assignment, self.points_earned, self.points_possible)

    def __str__(self):
        return "{} Scored {} out of {}".format(self.assignment, self.points_earned, self.points_possible)


class Room(models.Model):
    """
    Defines the Room database table

    Args:
        building = building code that this room is in (Voltaire, Kremlin, etc.)
        has_whiteboard = boolean, based on presence of whiteboard in room
        has_chalkboard = boolean, based on presence of chalkboard in room
        has_projector = boolean, based on presence of projector in room
        size = number of people/students that the room can accommodate
    """
    building = models.CharField(max_length=63)
    has_whiteboard = models.BooleanField()
    has_chalkboard = models.BooleanField()
    has_projector = models.BooleanField()
    size = models.IntegerField()

    def __repr__(self):
        return "Room(building={}, has_whiteboard={}, has_chalkboard={}, has_projector={}, size={})".format(
            self.building, self.has_whiteboard, self.has_chalkboard, self.has_projector, self.size)

    def __str__(self):
        return "{}".format(self.building)


class Schedule(models.Model):
    """
    Defines the Schedule database table

    Args:
        course_id = FK to a specific course
        date = date that a course will take place
        start_time = starting time for this course
        end_time = ending time for this course
        room_id = FK to the room where the course will be held
    """
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True, blank=True)
    start_time = models.TimeField()
    end_time = models.TimeField()
    room_id = models.ForeignKey(Room, on_delete=models.CASCADE)

    def __repr__(self):
        return "Schedule(course_id={}, date={}, start_time={}, end_time={}, room_id={})".format(self.course_id,
            self.date, self.start_time, self.end_time, self.room_id)

    def __str__(self):
        return " {} from {} - {} ".format(self.course_id, self.start_time, self.end_time)


class Attendance(models.Model):
    """
    Defines the Attendance database table

    Args:
        student_id = FK to a specific student
        schedule_id = FK to a specific schedule instance
        status = integer code to describe a student's status for that class (present, late, absent)
    """
    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)
    schedule_id = models.ForeignKey(Schedule, on_delete=models.CASCADE)
    status = models.IntegerField()

    def __repr__(self):
        return "Attendance(student_id={}, schedule_id={}, status={})".format(self.student_id,
            self.schedule_id, self.status)

    def __str__(self):
        return "{}, status: {}, {}".format(str(self.student_id), str(self.status), str(self.schedule_id))
