from django.test import TestCase, Client, RequestFactory
from epita.models import Student, Professor, Course, Room, Schedule, Attendance, StudentCourse
from epita.views import CourseView
from accounts.models import User
from django.urls import reverse

import datetime

'''
Model Tests

Below are our tests for the database objects, making sure that tables fit together properly
    
'''
class AttendanceTest(TestCase):
    def setUp(self):

        self.factory = RequestFactory()

        user0 = User.objects.create(first_name="first0", last_name="last0", external_email="external0@gmail.com",
                            email="epita0@epita.fr", is_staff=False, is_active=True, is_superuser=False)
        user0.set_password('abc')
        user0.save()

        Student.objects.filter(user__email="epita0@epita.fr").update(phone="123", program="ME",
                                                                     specialization="Software Engineering",
                                                                     classof="Fall 2017", country="USA",
                                                                     languages="English", photo_location="")

        User.objects.create(first_name="first1", last_name="last1", external_email="external1@gmail.com", password="abc",
                            email="epita1@epita.fr", is_staff=False, is_active=True, is_superuser=False)

        Student.objects.filter(user__email="epita1@epita.fr").update(phone="456", program="ME",
                                                                     specialization="Software Engineering",
                                                                     classof="Fall 2017", country="France",
                                                                     languages="English,French", photo_location="")

        User.objects.create(first_name="first2", last_name="last2", external_email="external2@gmail.com", password="abc",
                            email="epita2@epita.fr", is_staff=False, is_active=True, is_superuser=False)

        Student.objects.filter(user__email="epita2@epita.fr").update(phone="789", program="ME",
                                                                     specialization="Software Engineering",
                                                                     classof="Fall 2017", country="USA",
                                                                     languages="English", photo_location="")

        User.objects.create(first_name="prof", last_name="proflast", external_email="externalprof@gmail.com",
                            password="abc", email="epitaprof@epita.fr", is_staff=True, is_active=True, is_superuser=False)

        Professor.objects.filter(user__email="epitaprof@epita.fr").update(phone="0987654321")

        professor1 = Professor.objects.filter(user__email="epitaprof@epita.fr")[0]
        student0 = Student.objects.filter(user__email="epita0@epita.fr")[0]
        student1 = Student.objects.filter(user__email="epita1@epita.fr")[0]
        student2 = Student.objects.filter(user__email="epita2@epita.fr")[0]

        course0 = Course.objects.create(professor_id=professor1, title="Sample Course 0", description="Sample Description",
                                   semester="Spring 2018", module="Advanced Technology", credits=3)

        course1 = Course.objects.create(professor_id=professor1, title="Sample Course 1", description="Sample Description",
                                   semester="Spring 2018", module="Advanced Technology", credits=3)

        course2 = Course.objects.create(professor_id=professor1, title="Sample Course 2", description="Sample Description",
                                   semester="Spring 2018", module="Java", credits=3)

        room0 = Room.objects.create(building="kremlin", has_chalkboard=True, has_projector=True,
                                    has_whiteboard=False, size=50)

        room1 = Room.objects.create(building="kremlin", has_chalkboard=True, has_projector=True,
                                   has_whiteboard=True, size=20)


        # Give student0 both courses
        StudentCourse.objects.create(student_id=student0, course_id=course0)
        StudentCourse.objects.create(student_id=student0, course_id=course1)

        # Give student1 just the first course
        StudentCourse.objects.create(student_id=student1, course_id=course0)

        # Give student2 just the second course
        StudentCourse.objects.create(student_id=student2, course_id=course1)


        # Create 20 instances of a class schedule for course0
        for i in range(0,20):
            Schedule.objects.create(course_id=course0, date=datetime.date.today()+datetime.timedelta(days=i),
                                    start_time="10:00", end_time="11:00", room_id=room0)

        # Create 10 instances of a class schedule for course1
        for i in range(0,10):
            Schedule.objects.create(course_id=course1, date=datetime.date.today()+datetime.timedelta(days=i),
                                    start_time="10:00", end_time="11:00", room_id=room1)

        schedule0 = Schedule.objects.create(course_id=course1, date=datetime.date.today(), start_time="10:00",
                                            end_time="13:00", room_id=room0)

        schedule1 = Schedule.objects.create(course_id=course1, date=datetime.date.today(), start_time="14:00",
                                            end_time="16:00", room_id=room1)

        schedule2 = Schedule.objects.create(course_id=course2, date=datetime.date.today(), start_time="18:30",
                                            end_time="20:30", room_id=room1)

        Attendance.objects.create(student_id=student0, schedule_id=schedule0, status=1)
        Attendance.objects.create(student_id=student1, schedule_id=schedule1, status=2)

        for i in range(20):
            Attendance.objects.create(student_id=student2, schedule_id=schedule2, status=3)

    def test_models_course_count(self):
        student0_courses = StudentCourse.objects.filter(student_id__user__first_name__exact="first0").count()
        student1_courses = StudentCourse.objects.filter(student_id__user__first_name__exact="first1").count()
        student2_courses = StudentCourse.objects.filter(student_id__user__first_name__exact="first2").count()
        self.assertEqual(student0_courses, 2)
        self.assertEqual(student1_courses, 1)
        self.assertEqual(student2_courses, 1)

    def test_models_schedule_by_course(self):
        course0_schedules = Schedule.objects.filter(course_id__title__exact="Sample Course 0").count()
        course1_schedules = Schedule.objects.filter(course_id__title__exact="Sample Course 1").count()
        self.assertEqual(course0_schedules, 20)
        self.assertEqual(course1_schedules, 12)

    def test_models_attendance_by_schedule(self):
        schedule0_attendance = Attendance.objects.filter(schedule_id__course_id__title__exact="Sample Course 1").count()
        schedule1_attendance = Attendance.objects.filter(schedule_id__course_id__title__exact="Sample Course 2").count()
        self.assertEqual(schedule0_attendance, 2)
        self.assertEqual(schedule1_attendance, 20)

    def test_course_view_status_code_and_template(self):
        url = reverse('course_list')
        student_instance = User.objects.get(first_name="first0")
        self.client.login(email=student_instance.email, password='abc')
        course_list = Attendance.objects.filter(student_id__user_id=student_instance)
        course_list = course_list.order_by('schedule_id__course_id__title')
        course_list = course_list.values_list('schedule_id__course_id__title', flat=True)
        self.response = self.client.get(url, {'course_list': course_list})
        self.assertEqual(self.response.status_code, 200)
        self.assertTemplateUsed(self.response, 'epita/course_list.html')

    # def test_schedule_view_status_code_and_template(self):
    #     url = reverse('schedule_list')
    #     self.response = self.client.get(url, {'course_id':1})
    #     self.assertEqual(self.response.status_code, 200)
    #     self.assertTemplateUsed(self.response, 'epita/schedule_list.html')
    #
    # def test_attendance_view_status_code_and_template(self):
    #     url = reverse('attendance_list')
    #     self.response = self.client.get(url, {'schedule_id':1})
    #     self.assertEqual(self.response.status_code, 200)
    #     self.assertTemplateUsed(self.response, 'epita/attendance_list.html')

    def test_schedule_view_contains_courses(self):
        self.assertIsNot(self, Schedule.objects.all(), [])

    def test_attendance_view_contains_students(self):
        self.assertIsNotNone(Attendance.objects.get(id=1))

