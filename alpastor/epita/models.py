from django.db import models
from accounts.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
import re
import datetime
from django.utils.timezone import now


@receiver(post_save, sender=User)
def create_user_student_or_prof(sender, instance, created, **kwargs):
    """
    Automatically creates a record of student/professor, depending on is_staff bool

    This is a signal-function, meaning it gets fired on the 'post_save' signal

    :param sender:      User model instance (from accounts/models.py)
    :param instance:    The instance of the created User
    :param created:     Boolean indicating whether User was successfully created
    :param kwargs:      Additional keyword args
    :return:            None
    """
    if created:
        if not instance.is_staff:
            Student.objects.create(user=instance)
        elif not instance.is_superuser:
            Professor.objects.create(user=instance)


@receiver(post_save, sender=User)
def save_user_student(sender, instance, **kwargs):
    """
    Automatically saves/stores a record of student/professor, depending on is_staff bool

    This is a signal-function, meaning it gets fired on the 'post_save' signal
    :param sender:      User model instance (from accounts/models.py)
    :param instance:    The instance of the created User
    :param kwargs:      Additional keyword args
    :return:            None
    """
    if not instance.is_staff:
        instance.student.save()
    elif not instance.is_superuser:
        instance.professor.save()


class Student(models.Model):
    """
    Defines the Student database table

    Args:
        user = FK to User table (containing email and names)
        phone = phone number, in string form, to allow international + symbols
        program = student's overall program (ME, MSc)
        specialization = student's sub specialty (Software Engineering, ISM, etc.)
        intakeSemester = class that student joined, form of Season Year (Fall 2017, Spring 2016)
        country = country of origin for the student
        city = city of origin for the student
        languages = which languages the student speaks, comma separated (English,French)
        photo_location = path on server to the stored location of the student's photo
    """

    NONE = 0

    # Programs
    ME = 1
    MSc = 2
    GITM = 3

    PROGRAM_CHOICES = [
        (NONE, 'None'),
        (ME, 'Master of Engineering'),
        (MSc, 'Master of Science'),
        (GITM, 'Global IT Management'),
    ]

    # Specializations
    SE = 1
    ISM = 2
    DSA = 3
    CS = 4
    SDM = 5
    SDS = 6

    SPECIALIZATION_CHOICES = [
        (NONE, 'None'),
        (SE, 'Software Engineering'),
        (ISM, 'Information Systems Management'),
        (DSA, 'Data Science & Analytics'),
        (CS, 'Computer Security'),
        (SDM, 'Software Development & Multimedia'),
        (SDS, 'Systems Networks & Security'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=31)
    program = models.IntegerField(choices=PROGRAM_CHOICES, default=NONE, blank=False)
    specialization = models.IntegerField(choices=SPECIALIZATION_CHOICES, default=NONE, blank=False)
    intakeSemester = models.CharField(max_length=31)
    country = models.CharField(max_length=127)
    country_code = models.CharField(max_length=2, blank=True)
    city = models.CharField(max_length=127, blank=True)
    languages = models.CharField(max_length=127, blank=True)
    photo_location = models.CharField(max_length=511, blank=True)

    def __repr__(self):
        return "Student(first_name={}, last_name={}, external_email={}, epita_email={}, phone={}, program={}, " \
               "specialization={}, intakeSemester={}, country={}, country_code={}, city={}, languages={}, photo_location={}" \
               ")".format(self.user.first_name, self.user.last_name, self.user.external_email, self.user.email, self.phone,
                          self.program, self.specialization, self.intakeSemester, self.country, self.country_code, self.city,
                          self.languages, self.photo_location)

    def __str__(self):
        return self.user.get_full_name()

    def get_non_none_program_choices(self):
        tmp = []
        for val,name in Student.PROGRAM_CHOICES:
            if val != Student.NONE:
                tmp.append((val, name))
        return tmp

    def get_non_none_specialization_choices(self):
        tmp = []
        for val,name in Student.SPECIALIZATION_CHOICES:
            if val != Student.NONE:
                tmp.append((val, name))
        return tmp


class Professor(models.Model):
    """
    Defines the Professor database table

    Args:
        user = FK to User table (containing email and names)
        phone = phone number, in string form, to allow international + symbols
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=31)
    photo_location = models.CharField(max_length=511, blank=True)

    def __repr__(self):
        return "Professor(first_name={}, last_name={}, external_email={}, epita_email={}, phone={})".format(
            self.user.first_name, self.user.last_name, self.user.external_email, self.user.email, self.phone)

    def __str__(self):
        return "{} {}".format(self.user.first_name, self.user.last_name)


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
    description = models.TextField(max_length=1000, blank=True)
    semester = models.CharField(max_length=31)
    module = models.CharField(max_length=63, blank=True)
    credits = models.IntegerField()
    slug = models.SlugField(max_length=158, blank=False, default='course-slug')

    def clean(self):
        super(Course, self).clean()

        # Reduce unnecessary spacing
        self.title = re.sub(' +', ' ', self.title)

        # Save slug field (e.g. fall-2019-advanced-c-programming
        self.slug = self.semester.lower().replace(' ', '-') + '-' + self.title.lower().replace(' ', '-')

    def save(self, **kwargs):
        self.full_clean()
        super(Course, self).save()

    def __repr__(self):
        return "Course(professor_id={}, title={}, description={}, semester={}, module={}, credits={})".format(
            self.professor_id, self.title, self.description, self.semester, self.module, self.credits)

    def __str__(self):
        return "{}".format(self.title)

    def verbose_title(self):
        return "{} ({})".format(self.title, self.semester)


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


class Schedule(models.Model):
    """
    Defines the Schedule database table

    Args:
        course_id = FK to a specific course
        date = date that a course will take place
        start_time = starting time for this course
        end_time = ending time for this course
    """
    course_id = models.ForeignKey(Course, on_delete=models.CASCADE)
    date = models.DateField(default=now)
    start_time = models.TimeField(default=now)
    end_time = models.TimeField(default=now() + datetime.timedelta(hours=2))
    attendance_closed = models.BooleanField(blank=False, default=True)

    def __repr__(self):
        return "Schedule(course_id={}, date={}, start_time={}, end_time={})".format(self.course_id,
            self.date, self.start_time, self.end_time)

    def __str__(self):
        return "{} {}".format(self.course_id, self.date)


class Attendance(models.Model):
    """
    Defines the Attendance database table

    Args:
        student_id = FK to a specific student
        schedule_id = FK to a specific schedule instance
        status = integer code to describe a student's status for that class (present, absent, excused)
        file_upload = file for excused absence
        upload_time = timestamp of file upload
    """
    PRESENT = 1
    ABSENT = 2
    EXCUSED = 3

    ATTENDANCE_CHOICES = [
        (PRESENT, 'Present'),
        (ABSENT, 'Absent'),
        (EXCUSED, 'Excused'),
    ]

    student_id = models.ForeignKey(Student, on_delete=models.CASCADE)
    schedule_id = models.ForeignKey(Schedule, on_delete=models.CASCADE)
    status = models.IntegerField(choices=ATTENDANCE_CHOICES, default=ABSENT)
    file_upload = models.FileField(null=True, blank=True)
    upload_time = models.DateTimeField(null=True, blank=True)

    def __repr__(self):
        return "Attendance(student_id={}, schedule_id={}, status={}, file_upload={}, upload_time={})".format(self.student_id,
            self.schedule_id, self.status, self.file_upload, self.upload_time)

    def __str__(self):
        return "{}, status: {}, {}, file: {}, time: {}".format(str(self.student_id), str(self.status), str(self.schedule_id), self.file_upload, self.upload_time)

@receiver(post_save, sender=Schedule)
def create_attendance_instances(sender, instance, created, **kwargs):
    if created:
        student_courses = StudentCourse.objects.filter(course_id=instance.course_id).select_related('student_id')
        for sc in student_courses:
            Attendance.objects.get_or_create(
                student_id=sc.student_id,
                schedule_id=instance,
            )