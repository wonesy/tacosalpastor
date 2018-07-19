from django.views.generic import View
from epita.models import Student, Professor, Course, StudentCourse, Attendance, Schedule, string_to_choice
from django.utils import timezone
from django.shortcuts import render
from django.db.models import Count
from django.http import QueryDict, JsonResponse
import json

def isSelected(value):
    if value == None or value == 'Any':
        return False
    return True

class AttendanceGraphs(View):
    template_name = 'epita/graphs.html'

    def get(self, request, *args):

        semester_year = timezone.now().year - 1
        semester_season = Student.FALL

        all_data = self.default_graph_by_program(semester_season, semester_year)
        attendance_data = json.dumps(all_data)

        return render(request, self.template_name, {'all_data': attendance_data})

    def post(self, request):

        initNames = json.loads(QueryDict(request.body)['initNames'])
        chart_data = QueryDict(request.body)['chartData']
        chart_dict = json.loads(chart_data)

        # Get the query data
        year = chart_dict['year']
        season = string_to_choice(Student.SEASON_CHOICES, chart_dict['season'])
        program = chart_dict['program']
        specialization = chart_dict['specialization']
        course = chart_dict['course']
        student_name = chart_dict['student']

        return_data = {
            "data": None,
            "names": None
        }

        student_data = None
        if initNames:
            student_list = StudentCourse.objects.filter(course_id__semester_season=season,
                                                        course_id__semester_year=year).select_related('student_id')

            names = []
            for student in student_list:
                name = student.student_id.user.get_full_name()
                if name not in names:
                    names.append(name)
            student_data = json.dumps(names)

            return_data['names'] = student_data

        '''
        Our models guarantee the SEASON and YEAR will always be selected, so we do not need
        to switch based on these parameters

        OPTIONS:

            = SPECIALIZATION :: X
            ====> whole_semester_by_specialization

            = COURSE :: X
            ====> whole_semester_by_class

            = COURSE :: STUDENT :: X
            ====> whole_semester_by_student_by_class
        '''
        attendance_data = []

        # Nothing selected
        if not isSelected(specialization)       \
            and not isSelected(course)      \
            and not isSelected(program)     \
            and not isSelected(student_name):
            all_data = self.default_graph_by_program(season, year)
            attendance_data = json.dumps(all_data)

        # Only semester is selected
        elif isSelected(specialization)       \
            and not isSelected(course)      \
            and not isSelected(program)     \
            and not isSelected(student_name):
            all_data = self.whole_semester_by_specialization(season, year, specialization)
            attendance_data = json.dumps(all_data)

        return_data['data'] = attendance_data

        return JsonResponse(return_data)


        # Switch on the requested parameters

        # data = self.whole_semester_by_specialization(semester_season=season, semester_year=year,
                                              # specialization_val=string_to_choice(Student.SPECIALIZATION_CHOICES, specialization))
        # return JsonResponse(data)


    def build_attendance_results(self, attendance_list):
        present = 0
        absent = 0
        excused = 0

        for i in attendance_list:
            if i['status'] == Attendance.PRESENT:
                present += 1
            elif i['status'] == Attendance.ABSENT:
                absent += 1
            elif i['status'] == Attendance.EXCUSED:
                excused += 1
        return {'present': present, 'absent': absent, 'excused': excused}

    def default_graph_by_program(self, semester_season, semester_year):
        programs = Student.PROGRAM_CHOICES
        program_list = []
        specialization_list = []
        course_list = []

        for program in programs:
            attendances = list(Attendance.objects.filter(student_id__program=program[0],
                                                         schedule_id__course_id__semester_year=semester_year,
                                                         schedule_id__course_id__semester_season=semester_season).values('status'))
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['program'] = program[1]
            program_list.append(attendance_results)

        for specialization in Student.SPECIALIZATION_CHOICES:
            specialization_list.append(specialization[1])

        for course in Course.objects.filter(semester_season=semester_season, semester_year=semester_year):
            course_list.append(course.title)


        attendance_data = {
            "season": semester_season,
            "year": semester_year,
            "attendance": program_list,
            "specialization": specialization_list,
            "course": course_list
        }

        return attendance_data

    def whole_semester_by_specialization(self, semester_season, semester_year, specialization_val):
        course_data = []

        specialization = string_to_choice(Student.SPECIALIZATION_CHOICES, specialization_val)

        courses = StudentCourse.objects.filter(student_id__specialization=specialization,
                                               course_id__semester_year=semester_year,
                                               course_id__semester_season=semester_season).values('course_id').distinct()

        for course in courses:
            course_obj = Course.objects.get(id=course['course_id'])
            attendances = list(Attendance.objects.filter(schedule_id__course_id__id=course['course_id']).values('status'))
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['title'] = course_obj.title
            course_data.append(attendance_results)

            print(attendance_results)

        attendance_data = {'specialization': specialization_val, 'course_data': course_data}

        return attendance_data

    def whole_semester_by_class(self, course, semester):
        schedule = Schedule.objects.filter(course_id__title=course, course_id__semester=semester)
        attendance_list = []

        for i in schedule:
            attendances = Attendance.objects.filter(schedule_id__date=i.date).values('status')
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['date'] = i.date

            attendance_list.append(attendance_results)
        attendance_data = {'course': course, 'semester': semester, 'attendance': attendance_list}
        return attendance_data

    def whole_semester_by_student_by_class(self, email, course):
        attendance = Attendance.objects.filter(student_id__user__email=email, schedule_id__course_id__title=course)
        student_name = Student.objects.filter(user__email=email)[0].user.get_full_name()
        attendance_data = {'name': student_name, 'course': course,'attendance': []}

        for i in attendance:
            attendance_data['attendance'].append({'date': i.schedule_id.date, 'status': i.status})

        return attendance_data

    def individual_student_allclass(self, name):
        student = Student.objects.filter(user__first_name=name)[0]
        allcourse = StudentCourse.objects.filter(student_id__user__first_name=name)
        student_name = student.user.get_full_name()
        attendance_data = {'name': student_name, 'student': []}
        for course in range(len(allcourse)):
            data = Attendance.objects.filter(student_id__user__first_name=name,
                                             schedule_id__course_id__title=allcourse[course].course_id).values(
                'status').annotate(status_count=Count('status'))
            status_list = list(data)
            attendance_data['student'].append({'course': allcourse[course].course_id.title, 'status': status_list})
        return attendance_data

    def individual_student_allclass(self, name):

        student = Student.objects.filter(user__first_name=name)[0]
        allcourse = StudentCourse.objects.filter(student_id__user__first_name=name)
        # print(allcourse)
        stdname = student.user.get_full_name()
        status = Attendance.objects.filter(student_id__user__first_name=name,
                                           schedule_id__course_id__title=allcourse[0].course_id).values('status')
        # print(status)

        attendance_data = {'name': stdname, 'student': []}

        for y in range(len(allcourse)):
            b = Attendance.objects.filter(student_id__user__first_name=name,
                                          schedule_id__course_id__title=allcourse[y].course_id).values('status')

            print(b)
            attendance_data['student'].append({'course': allcourse[y].course_id.title, 'st': b})
            # attendance_data['student'].append({'st': b})
        # print(attendance_data)

        # attendance_data['student'].append({'allcourse': allcourse})
        # attendance_data['student'][0]['allcourse'] = []
        #
        # for x in allcourse:
        #     attendance_data['student'].append({'course': x.course_id.title})
        #
        # print(x)
        # print(attendance_data)
        #
        # for i in student:
        #     attendance_data['student'][0]['allcourse'].append({'status': i.status})
        #     print('attendace data')
        #     print(attendance_data)
        return attendance_data


    def individual_professor_allclass_by_semester(self, name, semester):
        professor = Professor.objects.filter(user__first_name=name)[0]
        # print(professor)
        courses = Course.objects.filter(professor_id__user__first_name=name).distinct()
        print(courses)
        # course_attendance1 = Attendance.objects.filter(schedule_id__course_id__professor_id__user__first_name=name,
        #                                               schedule_id__course_id__title=courses[0]).values(
        #     'status').annotate(status_count=Count('status'))
        # print(course_attendance1)
        # course_attendance = Attendance.objects.filter(schedule_id__course_id__professor_id__user__first_name=name,
        #                                               schedule_id__course_id__title=courses[1]).values(
        #     'status').annotate(status_count=Count('status'))
        # print(course_attendance)
        professor_name = professor.user.get_full_name()
        p_attendance_data = {'name': professor_name, 'professor': []}
        # print(p_attendance_data)
        for x in range(len(courses)):
            course_attendance = Attendance.objects.filter(schedule_id__course_id__professor_id__user__first_name=name,
                                                          schedule_id__course_id__semester=semester,
                                                          schedule_id__course_id__title=courses[x]).values(
                'status')
            s_list = list(course_attendance)
            p_attendance_data['professor'].append({'course': courses[x].title, 'status': s_list})
            return p_attendance_data

    def individual_professor_allclass(self, name):
        professor = Professor.objects.filter(user__first_name=name)[0]
        course = 'Advanced C Programming'
        courses = Course.objects.filter(professor_id__user__first_name=name, title=course)
        print(courses)
        semester_attendance = Attendance.objects.filter(schedule_id__course_id__semester=courses[1].semester).values(
            'status').annotate(status_count=Count('status'))
        print(semester_attendance)
        professor_name = professor.user.get_full_name()
        p_attendance_data = {'name': professor_name, 'course name': course, 'professor': []}
        for x in range(len(courses)):
            semester_attendance = Attendance.objects.filter(
                schedule_id__course_id__semester=courses[x].semester).values(
                'status').annotate(status_count=Count('status'))
            s_list = list(semester_attendance)
            print("printing s_list")
            print(s_list)
            p_attendance_data['professor'].append({'course semester': courses[1].semester, 'status': s_list})
            return p_attendance_data
