from django.http import HttpResponse, QueryDict, JsonResponse
from django.utils import timezone
from django.views import View
from epita.models import Student, string_to_choice
from alpastor.settings import MEDIA_ROOT
from django.core.files.storage import FileSystemStorage
import csv
import json
import logging
import os
from io import StringIO
from django.db.models import Q

logger = logging.getLogger(__name__)

def csv_mkdir():
    dir = MEDIA_ROOT + "/csv"
    if not os.path.exists(dir):
        os.makedirs(dir)

def set_if_not_none(mapping, key, value):
    if value is not None:
        mapping[key] = value

# def dict_to_csv_filename(dictionary):
#     name = "_".join([key + str(dictionary[key]) for key in dictionary.keys()])
#     return name + ".csv"

class StudentToCSVView(View):
    def post(self, request, *args, **kwargs):
        csv_mkdir()

        #fs = FileSystemStorage(location='csv/')

        students = self.get_queryset(request)

        field_names = [f.name for f in Student._meta.fields]

        now = timezone.now()
        ajax_download_url = "/csv/students-{}-{}-{}_{}-{}-{}.csv".format(
            now.year, now.month, now.day, now.hour, now.minute, now.second
        )

        name = MEDIA_ROOT + ajax_download_url


        with open(name, "w") as csv_file:
            wr = csv.writer(csv_file, delimiter=",")
            wr.writerow(field_names)
            for student in students:
                wr.writerow([str(getattr(student, f)) for f in field_names])

        #fs.save(name)

        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = 'attachment; filename="{}"'.format(name)

        return JsonResponse({"location": "/media" + ajax_download_url})

    def get_queryset(self, request):
        data = json.loads(QueryDict(request.body).get('students'))
        search = data['search']
        program_list = data['program']
        specialization_list = data['specialization']
        intake_season_list = data['intake_season']
        intake_year_list = data['intake_year']

        # The rest of the filters that can be searched via the search bar
        # This query translates to: "return if you find ${search} in any of the following columns"
        q_object = Q(user__first_name__icontains=search)    | \
                   Q(user__last_name__icontains=search)     | \
                   Q(country__icontains=search)             | \
                   Q(user__email__icontains=search)         | \
                   Q(user__external_email__icontains=search)

        # Query: if program in program_list
        program_q_object = Q(_connector=Q.OR)
        for p in program_list:
            value = string_to_choice(Student.PROGRAM_CHOICES, p)
            program_q_object.add(Q(program=value), program_q_object.connector)

        # Query: if specialization in specialization_list
        specialization_q_object = Q(_connector=Q.OR)
        for s in specialization_list:
            value = string_to_choice(Student.SPECIALIZATION_CHOICES, s)
            specialization_q_object.add(Q(specialization=value), specialization_q_object.connector)


        # Query: if intake_season in intake_season_list
        season_q_object = Q(_connector=Q.OR)
        for s in intake_season_list:
            value = string_to_choice(Student.SEASON_CHOICES, s)
            season_q_object.add(Q(intake_season=value), season_q_object.connector)

        # Query: if intake_year in intake_year_list
        year_q_object = Q(_connector=Q.OR)
        for y in intake_year_list:
            year_q_object.add(Q(intake_year=y), season_q_object.connector)

        return Student.objects.filter(q_object,
                                      program_q_object,
                                      specialization_q_object,
                                      season_q_object,
                                      year_q_object)