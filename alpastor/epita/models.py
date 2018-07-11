from django.db import models
from alpastor import settings
from accounts.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from django_countries.fields import CountryField
import re
import datetime
from django.utils.timezone import now

def choice_to_string(choices, index):
    return [x[1] for x in choices][index]

def string_to_choice(choices, val):
    for x in choices:
        if x[1] == val:
            return x[0]

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
    FGITM = 3
    EXCHANGE = 4

    PROGRAM_CHOICES = [
        (NONE, 'None'),
        (ME, 'Master of Engineering'),
        (MSc, 'Master of Science'),
        (FGITM, 'Global IT Management (French)'),
        (EXCHANGE, "Exchange"),
    ]

    # Specializations
    SE = 1
    ISM = 2
    DSA = 3
    CS = 4
    SDM = 5
    SDS = 6
    IGITM = 7
    AI = 8

    SPECIALIZATION_CHOICES = [
        (NONE, 'None'),
        (SE, 'Software Engineering'),
        (ISM, 'Information Systems Management'),
        (DSA, 'Data Science and Analytics'),
        (CS, 'Computer Security'),
        (SDM, 'Software Development and Multimedia'),
        (SDS, 'Systems Networks & Security'),
        (IGITM, 'Global IT Management (International)'),
        (AI, "Artificial Intelligence"),
    ]

    # Enrollment status
    ENROLLED = 0
    WITHDRAWN = 1
    EXPELLED = 2
    GRADUATED = 3

    ENROLLMENT_CHOICES = [
        (ENROLLED, 'Enrolled'),
        (WITHDRAWN, 'Withdrawn'),
        (EXPELLED, 'Expelled'),
        (GRADUATED, 'Graduated'),
    ]

    # Additional Flags
    OK = 0
    ACADEMIC_WARNING = 1
    ATTENDANCE_WARNING = 2

    ADDITIONAL_FLAGS = [
        (OK, "OK"),
        (ACADEMIC_WARNING, "Academic warning"),
        (ATTENDANCE_WARNING, "Attendance warning"),
    ]

    # Seasons
    WINTER = 0
    SPRING = 1
    SUMMER = 2
    FALL = 3

    SEASON_CHOICES = [
        (WINTER, "Winter"),
        (SPRING, "Spring"),
        (SUMMER, "Summer"),
        (FALL, "Fall"),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=31)
    program = models.IntegerField(choices=PROGRAM_CHOICES, default=NONE, blank=False)
    specialization = models.IntegerField(choices=SPECIALIZATION_CHOICES, default=NONE, blank=False)
    intake_season = models.IntegerField(choices=SEASON_CHOICES, default=FALL, blank=False)
    intake_year = models.IntegerField(blank=False, default=now().year)
    country = CountryField(help_text="country", blank_label="Select a country", countries_flag_url="flags/{code}.jpg")
    city = models.CharField(max_length=127, blank=True, help_text="City of origin")
    languages = models.CharField(max_length=127, blank=True)
    photo_location = models.CharField(max_length=511, null=True, blank=True)
    address_street = models.CharField(max_length=255, null=True, blank=True, help_text="Street")
    address_city = models.CharField(max_length=255, null=True, blank=True, help_text="City")
    address_misc = models.CharField(max_length=255, null=True, blank=True, help_text="Building, mailbox, etc.")
    postal_code = models.IntegerField(blank=True, null=True, help_text="Department postal code")
    dob = models.DateField(null=True, blank=True, help_text="Date of birth", verbose_name="Date of Birth")
    enrollment_status = models.IntegerField(choices=ENROLLMENT_CHOICES, default=ENROLLED, blank=False, help_text="Enrollment status")
    flags = models.IntegerField(choices=ADDITIONAL_FLAGS, default=OK, blank=False, help_text="Student flags")

    def __repr__(self):
        return "Student(first_name={}, last_name={}, external_email={}, epita_email={}, phone={}, program={}, " \
               "specialization={}, intake_season={}, intake_year={}, country={}, city={}, languages={}, photo_location={}" \
               ")".format(self.user.first_name, self.user.last_name, self.user.external_email, self.user.email, self.phone,
                          self.program, self.specialization, self.intake_season, self.intake_year, self.country.name, self.city,
                          self.languages, self.photo_location)

    def __str__(self):
        return self.user.get_full_name()

    def student_email(self):
        return self.user.email

    def country_name(self):
        return self.country.name

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

    def professor_email(self):
        return self.user.email


class Course(models.Model):
    """
    Defines the Course database table

    Args:
        professor_id = FK to the Professor table, indicating who is teaching it
        title = title of the course
        description = fuller description of the course
        semester_season = the semester season in which the course will be taught (Spring)
        semester_year = the semester year in which the course will be taught (2020)
        module = the grading module that this course falls under (Technical, Business, etc)
        credits = the number of credits that will be offered for this course

    Note:
         columns 'title' and 'semester_year' and 'semester_season' must be unique as a pair, meaning you cannot have the same course title
         during the same semester (year + season)
    """
    class Meta:
        unique_together = (('title', 'semester_season', 'semester_year'),)

    professor_id = models.ForeignKey(Professor, on_delete=models.CASCADE, blank=True)
    code = models.CharField(max_length=127, blank=True, help_text="Course code e.g. ADVC123123", null=True)
    title = models.CharField(max_length=127, help_text="Course title")
    description = models.TextField(max_length=1000, blank=True, help_text="Course description")
    semester_season = models.IntegerField(choices=Student.SEASON_CHOICES)
    semester_year = models.IntegerField(blank=False, default=now().year)
    module = models.CharField(max_length=63, null=True, blank=True, help_text="Module or teaching unit")
    credits = models.IntegerField(null=True, blank=True)
    hours = models.IntegerField(null=True, blank=True)
    slug = models.SlugField(max_length=158, blank=False, default='course-slug')

    def clean(self):
        super(Course, self).clean()

        # Reduce unnecessary spacing
        self.title = re.sub(' +', ' ', self.title)

        # Save slug field (e.g. fall-2019-advanced-c-programming
        slug_season = choice_to_string(Student.SEASON_CHOICES, self.semester_season)
        self.slug = slug_season.lower() + '-' + str(self.semester_year) + '-' + self.title.lower().replace(' ', '-')

    def save(self, **kwargs):
        self.full_clean()
        super(Course, self).save()

    def __repr__(self):
        return "Course(professor_id={}, title={}, description={}, full_semester={}, module={}, credits={})".format(
            self.professor_id, self.title, self.description, self.full_semester(), self.module, self.credits)

    def __str__(self):
        return "{}".format(self.title)

    def verbose_title(self):
        return "{} ({})".format(self.title, self.full_semester())

    def full_semester(self):
        return "{} {}".format(choice_to_string(Student.SEASON_CHOICES, self.semester_season), self.semester_year)

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

def excuse_file_path(instance, filename):
    return "excuse_documents/student_id_{0}/{1}".format(instance.student_id.id, filename)

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
    file_upload = models.FileField(null=True, blank=True, upload_to=excuse_file_path)
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