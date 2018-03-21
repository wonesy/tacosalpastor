from django.test import TestCase
from django.test import Client
from epita.models import Student
from epita.models import Course
from epita.models import StudentCourse
from epita.models import Professor
from epita.models import Room
from epita.models import Schedule
from accounts.models import User
from epita.models import Attendance
import datetime

'''
Model Tests

Below are our tests for the database objects, making sure that tables fit together properly
    
'''
class StudentCourseTest(TestCase):
    def setUp(self):

        User.objects.create(first_name="fn0", last_name="ln0", external_email="external0@gmail.com", password="abc",
                            email="epita0@epita.fr", is_staff=False, is_active=True, is_superuser=False)

        Student.objects.filter(user__email="epita0@epita.fr").update(phone="123", program="ME",
                                                                     specialization="Software Engineering",
                                                                     classof="Fall 2017", country="USA",
                                                                     languages="English", photo_location="")

        User.objects.create(first_name="fn1", last_name="ln1", external_email="external1@gmail.com", password="abc",
                            email="epita1@epita.fr", is_staff=False, is_active=True, is_superuser=False)

        Student.objects.filter(user__email="epita1@epita.fr").update(phone="456", program="ME",
                                                                     specialization="Software Engineering",
                                                                     classof="Fall 2017", country="France",
                                                                     languages="English,French", photo_location="")

        User.objects.create(first_name="fn2", last_name="ln2", external_email="external2@gmail.com", password="abc",
                            email="epita2@epita.fr", is_staff=False, is_active=True, is_superuser=False)

        Student.objects.filter(user__email="epita2@epita.fr").update(phone="789", program="ME",
                                                                     specialization="Software Engineering",
                                                                     classof="Fall 2017", country="USA",
                                                                     languages="English", photo_location="")

        User.objects.create(first_name="prof", last_name="proflast", external_email="externalprof@gmail.com",
                            password="abc", email="epitaprof@epita.fr", is_staff=True, is_active=True, is_superuser=False)

        Professor.objects.filter(user__email="epitaprof@epita.fr").update(phone="0987654321")

        p = Professor.objects.filter(user__email="epitaprof@epita.fr")[0]
        s0 = Student.objects.filter(user__email="epita0@epita.fr")[0]
        s1 = Student.objects.filter(user__email="epita1@epita.fr")[0]
        s2 = Student.objects.filter(user__email="epita2@epita.fr")[0]

        c0 = Course.objects.create(professor_id=p, title="Sample Course 0", description="Sample Description",
                                   semester="Spring 2018", module="Advanced Technology", credits=3)

        c1 = Course.objects.create(professor_id=p, title="Sample Course 1", description="Sample Description",
                                   semester="Spring 2018", module="Advanced Technology", credits=3)

        # Give s0 both courses
        StudentCourse.objects.create(student_id=s0, course_id=c0)
        StudentCourse.objects.create(student_id=s0, course_id=c1)

        # Give s1 just the first course
        StudentCourse.objects.create(student_id=s1, course_id=c0)

        # Give s2 just the second course
        StudentCourse.objects.create(student_id=s2, course_id=c1)

        room = Room.objects.create(building="kremlin", has_chalkboard=True, has_projector=True,
                                   has_whiteboard=True, size=100)

        # Create 20 instances of a class schedule for c0
        for i in range(0,20):
            Schedule.objects.create(course_id=c0, date=datetime.date.today()+datetime.timedelta(days=i),
                                    start_time="10:00", end_time="11:00", room_id=room)

        for i in range(0,10):
            Schedule.objects.create(course_id=c1, date=datetime.date.today()+datetime.timedelta(days=i),
                                    start_time="10:00", end_time="11:00", room_id=room)

    def test_course_count(self):
        s0_courses = StudentCourse.objects.filter(student_id__user__first_name__exact="fn0").count()
        s1_courses = StudentCourse.objects.filter(student_id__user__first_name__exact="fn1").count()
        s2_courses = StudentCourse.objects.filter(student_id__user__first_name__exact="fn2").count()

        self.assertEqual(s0_courses, 2)
        self.assertEqual(s1_courses, 1)
        self.assertEqual(s2_courses, 1)

    def test_attendance_by_course(self):
        c0_schedules = Schedule.objects.filter(course_id__title__exact="Sample Course 0").count()
        c1_schedules = Schedule.objects.filter(course_id__title__exact="Sample Course 1").count()

        self.assertEqual(c0_schedules, 20)
        self.assertEqual(c1_schedules, 10)