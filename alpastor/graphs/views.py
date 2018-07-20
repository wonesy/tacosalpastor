from django.views.generic import View
from epita.models import Student, Course, StudentCourse, Attendance, string_to_choice
from django.shortcuts import render
from django.http import QueryDict, JsonResponse
from django.db.models import Q
from enum import Enum
import json

class Title(Enum):
    STUDENT_NAME = 0
    COURSE_TITLE = 1

def isSelected(value):
    if value == None or value == 'Any' or value == '-1':
        return False
    return True

def getJsonNames(queryset):
    names = {}
    for student in queryset:
        id = student.student_id.id
        name = student.student_id.user.get_full_name()
        if id not in names:
            names[id] = name
    return json.dumps(names)

class AttendanceGraphs(View):
    template_name = 'epita/graphs.html'

    def get(self, request, *args):
        return render(request, self.template_name)

    def post(self, request):

        chart_data = QueryDict(request.body)['chartData']
        chart_dict = json.loads(chart_data)

        # Get the query data
        year = chart_dict['year']
        season = string_to_choice(Student.SEASON_CHOICES, chart_dict['season'])
        program = chart_dict['program']
        specialization = chart_dict['specialization']
        course = chart_dict['course']
        student = chart_dict['student']

        return_data = {
            "data": None,
            "names": None
        }

        '''
        Our model guarantees the SEASON and YEAR will always be selected, so we do not need
        to switch based on these parameters
        '''

        # if there are no queries, run the default and return
        if not isSelected(program)              \
            and not isSelected(specialization)  \
            and not isSelected(student)         \
            and not isSelected(course):
            all_data, names = self.default_graph_by_season_year(season, year)
            attendance_data = json.dumps(all_data)

            return_data['data'] = attendance_data
            return_data['names'] = names

            return JsonResponse(return_data)

        # Otherwise, run the specific query
        organization = self.organize_by_course
        title = Title.STUDENT_NAME

        attendance_data = []
        names = []

        # Construct the query
        q_query = Q(course_id__semester_season=season) & Q(course_id__semester_year=year)

        if isSelected(specialization):
            val = string_to_choice(Student.SPECIALIZATION_CHOICES, specialization)
            q_query.add(Q(student_id__specialization=val), q_query.connector)

        if isSelected(program):
            val = string_to_choice(Student.PROGRAM_CHOICES, program)
            q_query.add(Q(student_id__program=val), q_query.connector)

        if isSelected(course):
            q_query.add(Q(course_id__title=course), q_query.connector)
            organization = self.organize_by_student

        if isSelected(student):
            q_query.add(Q(student_id__id=student), q_query.connector)

            if isSelected(course):
                title = Title.COURSE_TITLE

        queryset = StudentCourse.objects.filter(q_query).select_related('student_id')
        attendance_data = json.dumps(organization(queryset, title))
        print(attendance_data)
        names = getJsonNames(queryset)
        print(names)

        return_data['data'] = attendance_data
        return_data['names'] = names

        return JsonResponse(return_data)

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

    def organize_by_course(self, queryset, title):
        '''
        This will return data that is intended to be organized with 'course title' as the xAxis

        queryset contains database info from StudentCourse with student_id as select_related
        '''
        course_data = []
        courses = queryset.values('course_id').distinct()

        for course in courses:
            course_dict = {
                'title': '',
                'attendance': []
            }

            course_obj = Course.objects.get(id=course['course_id'])
            attendances = list(
                Attendance.objects.filter(schedule_id__course_id__id=course['course_id']).values('status'))
            attendance_results = self.build_attendance_results(attendances)

            course_dict['title'] = course_obj.title
            course_dict['attendance'].append(attendance_results)

            course_data.append(course_dict)

        return course_data

    def organize_by_student(self, queryset, title):
        '''
        This will return data that is intended to be organized with 'student name' as the xAxis

        queryset contains database info from StudentCourse with student_id as select_related
        '''
        student_data = []
        students = queryset.values_list('student_id').distinct()

        for student in students:
            student_dict = {
                'title': '',
                'attendance': []
            }

            attendances = list(Attendance.objects.filter(student_id=student[0]).values('status'))
            attendance_results = self.build_attendance_results(attendances)
            student_dict['attendance'].append(attendance_results)

            if title == Title.STUDENT_NAME:
                student_obj = Student.objects.get(id=student[0])
                student_dict['title'] = student_obj.user.get_full_name()
            elif title == Title.COURSE_TITLE:
                student_dict['title'] = queryset[0].course_id.title
            else:
                student_dict['title'] = "ERROR"


            student_data.append(student_dict)

        return student_data

    def default_graph_by_season_year(self, semester_season, semester_year):
        programs = Student.PROGRAM_CHOICES
        program_list = []
        specialization_list = []
        course_list = []
        attendance_data = []

        student_list = StudentCourse.objects.filter(course_id__semester_season=semester_season,
                                                    course_id__semester_year=semester_year).select_related('student_id')

        for program in programs:
            attendances = list(Attendance.objects.filter(student_id__program=program[0],
                                                         schedule_id__course_id__semester_year=semester_year,
                                                         schedule_id__course_id__semester_season=semester_season).values('status'))
            attendance_results = self.build_attendance_results(attendances)
            attendance_results['title'] = program[1]
            program_list.append(attendance_results)

        for specialization in Student.SPECIALIZATION_CHOICES:
            specialization_list.append(specialization[1])

        for course in Course.objects.filter(semester_season=semester_season, semester_year=semester_year):
            course_list.append(course.title)


        _tmp = {
            "season": semester_season,
            "year": semester_year,
            "attendance": program_list,
            "specialization": specialization_list,
            "course": course_list
        }

        attendance_data.append(_tmp)

        names = getJsonNames(student_list)

        return attendance_data, names
