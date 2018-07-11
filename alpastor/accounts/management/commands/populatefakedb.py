from django.core.management.base import BaseCommand
from epita.models import StudentCourse, Student, Professor, Course, Schedule, Attendance
from accounts.models import User
from django_countries import countries
from django.utils import timezone
from datetime import date
import random


class Command(BaseCommand):

    def handle(self, *args, **options):
        ####################################################################################################################
        #                                         POPULATE THE PROFESSORS                                                  #
        ####################################################################################################################

        User.objects.create_user(first_name="John", last_name="Professor", email="john.professor@epita.fr",
                                 password="asdf",
                                 is_registered=True, is_staff=True)
        prof_john = Professor.objects.get(user__email="john.professor@epita.fr")

        User.objects.create_user(first_name="Bill", last_name="Professor", email="bill.professor@epita.fr",
                                 password="asdf",
                                 is_registered=True, is_staff=True)
        prof_bill = Professor.objects.get(user__email="bill.professor@epita.fr")

        User.objects.create_user(first_name="Fred", last_name="Professor", email="fred.professor@epita.fr",
                                 password="asdf",
                                 is_registered=True, is_staff=True)
        prof_fred = Professor.objects.get(user__email="fred.professor@epita.fr")

        User.objects.create_user(first_name="Jake", last_name="Professor", email="jake.professor@epita.fr",
                                 password="asdf",
                                 is_registered=True, is_staff=True)
        prof_jake = Professor.objects.get(user__email="jake.professor@epita.fr")

        ####################################################################################################################
        #                                         POPULATE THE COURSES                                                     #
        ####################################################################################################################

        advc_s16 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.SPRING,
                                         semester_year=2016)
        advc_f16 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.FALL,
                                         semester_year=2016)
        advc_s17 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.SPRING,
                                         semester_year=2017)
        advc_f17 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.FALL,
                                         semester_year=2017)

        mgmt_f17 = Course.objects.create(title="Project Management", professor_id=prof_bill, credits=1,
                                         semester_season=Student.FALL, semester_year=2017)
        mgmt_s17 = Course.objects.create(title="Project Management", professor_id=prof_bill, credits=1,
                                         semester_season=Student.SPRING, semester_year=2017)
        mgmt_f18 = Course.objects.create(title="Project Management", professor_id=prof_bill, credits=1,
                                         semester_season=Student.FALL, semester_year=2018)

        java = Course.objects.create(title="Java", professor_id=prof_fred, credits=4, semester_season=Student.FALL,
                                     semester_year=2018)

        pri = Course.objects.create(title="PRI", professor_id=prof_jake, credits=4, semester_season=Student.FALL,
                                    semester_year=2018)

        ####################################################################################################################
        #                                         POPULATE THE STUDENTS                                                    #
        ####################################################################################################################

        country_list = list(countries)

        # create FALL 2016 population
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, len(country_list)-1)
            msc_user = User.objects.create_user(email="student{}_fall2016@epita.fr".format(i), first_name="John{}".format(i),
                                            last_name="Johnson", is_registered=True, password="asdf")
            Student.objects.filter(user=msc_user).update(program=Student.ME, specialization=Student.SE,
                                                               intake_season=Student.FALL, intake_year=2016,
                                                               country=country_list[country_idx][0])
            student = Student.objects.get(user=msc_user)
            StudentCourse.objects.create(student_id=student, course_id=advc_f16)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_s17)

        # create SPRING 2017 population
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, len(country_list)-1)
            msc_user = User.objects.create_user(email="student{}_spring2017@epita.fr".format(i), first_name="Will{}".format(i),
                                            last_name="Wilson", is_registered=True, password="asdf")
            Student.objects.filter(user=msc_user).update(program=Student.MSc, specialization=Student.DSA,
                                                               intake_season=Student.SPRING, intake_year=2017,
                                                               country=country_list[country_idx][0])
            student = Student.objects.get(user=msc_user)
            StudentCourse.objects.create(student_id=student, course_id=advc_s17)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_f17)

        # create FALL 2017 population
        # MSC students
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, len(country_list)-1)
            msc_user = User.objects.create_user(email="student{}_fall2017@epita.fr".format(i), first_name="Peter{}".format(i),
                                            last_name="Peterson", is_registered=True, password="asdf")
            Student.objects.filter(user=msc_user).update(program=Student.MSc, specialization=Student.DSA,
                                                               intake_season=Student.FALL, intake_year=2017,
                                                               country=country_list[country_idx][0])
            student = Student.objects.get(user=msc_user)
            StudentCourse.objects.create(student_id=student, course_id=advc_f17)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_f18)
            StudentCourse.objects.create(student_id=student, course_id=java)
            StudentCourse.objects.create(student_id=student, course_id=pri)

        # ME students
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, len(country_list) - 1)
            me_user = User.objects.create_user(email="student_me{}_fall2017@epita.fr".format(i),
                                                first_name="Joey{}".format(i),
                                                last_name="Joseph", is_registered=True, password="asdf")
            Student.objects.filter(user=me_user).update(program=Student.ME, specialization=Student.SDM,
                                                         intake_season=Student.FALL, intake_year=2017,
                                                         country=country_list[country_idx][0])
            student = Student.objects.get(user=me_user)
            StudentCourse.objects.create(student_id=student, course_id=advc_f17)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_f18)
            StudentCourse.objects.create(student_id=student, course_id=java)
            StudentCourse.objects.create(student_id=student, course_id=pri)


        ####################################################################################################################
        #                                         POPULATE THE SCHEDULES                                                   #
        ####################################################################################################################

        # Every month has at least 28 days
        for i in range(1, 28):
                # Creates courses with date of Fall 2017
                Schedule.objects.create(course_id=advc_f17, date=date(2017, 10, i), start_time=timezone.now(),
                                        end_time=timezone.now())

        ####################################################################################################################
        #                                         CHECK IN SOME STUDENTS                                                   #
        ####################################################################################################################


        all_attendance = Attendance.objects.all()
        attendance_count = all_attendance.count()
        print("MAX ATTENDANCE VALUES: %d", attendance_count)
        rand_range1 = random.randrange(0, attendance_count)
        print("CHANGING %d VALUES TO PRESENT", rand_range1)
        for i in range(rand_range1):
            Attendance.objects.filter(id=i).update(status=1)
        rand_range2 = random.randrange(0, (int(attendance_count / 5)))
        print("CHANGING %d VALUES TO EXCUSED", rand_range2)
        for i in range(0, rand_range2):
            Attendance.objects.filter(id=i).update(status=3)