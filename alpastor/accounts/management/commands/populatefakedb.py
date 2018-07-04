from django.core.management.base import BaseCommand
from epita.models import StudentCourse, Student, Professor, Course
from accounts.models import User
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
                                         semester_season=Student.FALL,
                                         semester_year=2016)
        advc_f16 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.SPRING,
                                         semester_year=2016)
        advc_s17 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.FALL,
                                         semester_year=2017)
        advc_f17 = Course.objects.create(title="Advanced C", professor_id=prof_john, credits=3,
                                         semester_season=Student.SPRING,
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

        country_list = ["USA", "India", "Canada", "France", "Brazil", "Mexico", "Germany", "China", "Spain",
                        "Italy", "Vietnam"]

        # create FALL 2016 population
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, 10)
            user = User.objects.create_user(email="student{}_fall2016@epita.fr".format(i), first_name="John{}".format(i),
                                            last_name="Johnson", is_registered=True, password="asdf")
            Student.objects.filter(user=user).update(program=Student.ME, specialization=Student.SE,
                                                               intake_season=Student.FALL, intake_year=2016,
                                                               country=country_list[country_idx])
            student = Student.objects.get(user=user)
            StudentCourse.objects.create(student_id=student, course_id=advc_f16)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_s17)

        # create SPRING 2017 population
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, 10)
            user = User.objects.create_user(email="student{}_spring2017@epita.fr".format(i), first_name="Will{}".format(i),
                                            last_name="Wilson", is_registered=True, password="asdf")
            Student.objects.filter(user=user).update(program=Student.MSc, specialization=Student.DSA,
                                                               intake_season=Student.SPRING, intake_year=2017,
                                                               country=country_list[country_idx])
            student = Student.objects.get(user=user)
            StudentCourse.objects.create(student_id=student, course_id=advc_s17)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_f17)

        # create FALL 2017 population
        for i in range(0, random.randrange(20, 85)):
            country_idx = random.randint(0, 10)
            user = User.objects.create_user(email="student{}_fall2017@epita.fr".format(i), first_name="Peter{}".format(i),
                                            last_name="Peterson", is_registered=True, password="asdf")
            Student.objects.filter(user=user).update(program=Student.MSc, specialization=Student.DSA,
                                                               intake_season=Student.SPRING, intake_year=2017,
                                                               country=country_list[country_idx])
            student = Student.objects.get(user=user)
            StudentCourse.objects.create(student_id=student, course_id=advc_f17)
            StudentCourse.objects.create(student_id=student, course_id=mgmt_f18)
            StudentCourse.objects.create(student_id=student, course_id=java)
            StudentCourse.objects.create(student_id=student, course_id=pri)
