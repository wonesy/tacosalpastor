from django.test import TestCase, Client, RequestFactory
from epita.models import Student, Professor, Course, Schedule, Attendance, StudentCourse
from epita.forms import AttendanceForm
from epita.views import CourseView
from accounts.models import User
from django.utils import timezone
from django.urls import reverse
import random
import json

import datetime

'''
Professor/Staff Attendance Testing
'''


class StaffAttendanceTest(TestCase):
    def setUp(self):
        # Create 2 users
        self.user0 = User.objects.create_user(email="professor0@epita.fr", password='pass', first_name='Alison', last_name='Anderson', is_staff=True)
        self.user1 = User.objects.create_user(email="professor1@epita.fr", password='pass', first_name='Bill', last_name='Barker', is_staff=True)

        self.prof0 = Professor.objects.get(user_id=self.user0)
        self.prof1 = Professor.objects.get(user_id=self.user1)

        # Create 4 courses
        self.course0 = Course.objects.create(professor_id=self.prof0, title="Advanced A", credits=3, semester_season=Student.FALL, semester_year=2020)
        self.course1 = Course.objects.create(professor_id=self.prof0, title="Advanced B", credits=3, semester_season=Student.FALL, semester_year=2020)
        self.course2 = Course.objects.create(professor_id=self.prof1, title="Advanced C", credits=3, semester_season=Student.FALL, semester_year=2020)
        self.course3 = Course.objects.create(professor_id=self.prof1, title="Advanced D", credits=3, semester_season=Student.FALL, semester_year=2020)


        # Create 50 students
        for i in range(0,50):
            email = "student{}@epita.fr".format(i)

            u = User.objects.create_user(email=email, password="pass", is_staff=False)
            s = Student.objects.get(user_id=u)

            # Assign the first 50 students to course0
            if i < 5:
                StudentCourse.objects.create(student_id=s, course_id=self.course0)

            # Assign the first 75 students to course1
            if i < 15:
                StudentCourse.objects.create(student_id=s, course_id=self.course1)

            # Assign the first 100 students to course2
            if i < 45:
                StudentCourse.objects.create(student_id=s, course_id=self.course2)

            # Assign all 150 students to course3
            StudentCourse.objects.create(student_id=s, course_id=self.course3)

        # Create X scheduled classes for each course
        for i in range(0,random.randint(1,10)):
            Schedule.objects.create(course_id=self.course0, date=timezone.now(), start_time=timezone.now(), end_time=timezone.now())

        for i in range(0,random.randint(1,10)):
            Schedule.objects.create(course_id=self.course1, date=timezone.now(), start_time=timezone.now(), end_time=timezone.now())

        for i in range(0, random.randint(1,10)):
            Schedule.objects.create(course_id=self.course2, date=timezone.now(), start_time=timezone.now(), end_time=timezone.now())

        for i in range(0, random.randint(1,10)):
            Schedule.objects.create(course_id=self.course3, date=timezone.now(), start_time=timezone.now(), end_time=timezone.now())


    def test_prof_attendance_profs2course(self):
        '''
        2 professors
        2 courses for each professor
        :return:
        '''
        self.assertEqual(2, Professor.objects.all().count())
        self.assertEqual(2, Course.objects.filter(professor_id=self.prof0).count())
        self.assertEqual(2, Course.objects.filter(professor_id=self.prof1).count())

    def test_prof_attendance_num_attendance_inst(self):
        '''
        Make sure the number of attendance records created was done automatically

        Algorithm:

            The number of attendance records is equal to the number of students enrolled in that class times
            the number of schedule instances made

            num_attendance = (num_students_enrolled * num_schedule_instances)
        :return:
        '''
        for course in [self.course0, self.course1, self.course2, self.course3]:
            num_students = StudentCourse.objects.filter(course_id=course).count()
            num_sched_instances = Schedule.objects.filter(course_id=course).count()
            num_attendance = Attendance.objects.filter(schedule_id__course_id=course).count()
            self.assertEqual(num_attendance, (num_sched_instances * num_students))

    def test_prof_manual_update(self):
        self.client.login(email="professor0@epita.fr", password="pass")

        url = reverse('override_attendance', kwargs={'slug': self.course0.slug})

        schedule = Schedule.objects.all()[0]

        data = {
            'schedule_id': str(schedule.id),
            'students': []
        }

        absent_students = Attendance.objects.filter(status=Attendance.ABSENT, schedule_id=schedule).select_related('student_id')
        present_students = Attendance.objects.filter(status=Attendance.PRESENT, schedule_id=schedule)

        self.assertNotEqual(absent_students.count(), present_students.count())

        tmpStudents = []
        for student in absent_students:
            attendance_data = {}
            attendance_data['id'] = student.student_id.id
            attendance_data['status'] = Attendance.PRESENT
            attendance_data['file_upload'] = ""
            attendance_data['name'] = student.student_id.user.get_full_name()
            attendance_data['image'] = ""

            tmpStudents.append(attendance_data)

        data['students'] = json.dumps(tmpStudents)

        response = self.client.post(url, data, kwargs={'HTTP_X_REQUESTED_WITH': 'XMLHttpRequest'})

        present_students = Attendance.objects.filter(status=Attendance.PRESENT, schedule_id=schedule)

        self.assertEqual(response.status_code, 302)
        self.assertEqual(present_students.count(), absent_students.count())

        self.client.logout()

    def test_prof_manual_update_as_student_fail(self):
        self.client.login(email="student1@epita.fr", password="pass")

        data = {
            'schedule_id': str(1),
            'students': []
        }

        url = reverse('override_attendance', kwargs={'slug': self.course0.slug})
        response = self.client.post(url, data, kwargs={'HTTP_X_REQUESTED_WITH': 'XMLHttpRequest'})

        self.assertEqual(400, response.status_code)

        self.client.logout()
