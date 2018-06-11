from django.shortcuts import render, redirect
from django.contrib.auth import logout
from django.contrib.auth import login as auth_login
from django.contrib.auth.decorators import user_passes_test
from accounts.forms import LoginForm
from epita.models import Student
from rest_framework import generics
from rest_framework.exceptions import bad_request
from django.http import HttpResponseRedirect, JsonResponse
import logging

logger = logging.getLogger(__name__)

# Create your views here.
def login(request):
    logout(request)
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            auth_login(request, form.get_user())
            return redirect(request.GET.get('next', 'home'))
    else:

        form = LoginForm()

    return render(request, 'accounts/login.html', {'form': form})

@user_passes_test(lambda u: u.is_superuser)
def manageusers(request):
    return render(request, 'accounts/manage_users.html', {
        'programs': Student.get_non_none_program_choices(None),
        'specializations': Student.SPECIALIZATION_CHOICES,
    })

class ProcessUserCSVData(generics.ListCreateAPIView):
    '''
    This class view is solely responsible for delivering JSON-formatted data on the updated attendance information
    for a particular schedule instance

    Serializers are simply fancy names for turning python model data (database queries) into JSON serialized data
    '''
    # serializer_class = AttendanceSerializer
    # queryset = Attendance.objects.all()

    first_name_opts = ["prenom", "first", "first_name", "firstname", "first name"]
    last_name_opts = ["nom", "last", "last_name", "lastname", "surname", "sur_name", "last name", "sur name"]
    program_opts = ["maj", "prog", "program", "major", "majeur"]
    email_opts = ["email", "mail", "courriel"]
    country_opts = ["country", "pays"]

    csv_positions = {
        'first_name' : -1,
        'last_name': -1,
        'email': -1,
        'program': -1,
        'country': -1
    }

    def get(self, request, *args, **kwargs):
        return bad_request(request, exception="Forbidden")

    def post(self, request, *args, **kwargs):
        all_users = []
        try:
            csv_file = request.FILES["file"]
            if not csv_file.name.endswith('.csv'):
                logger.error(request, 'File is not CSV type')
                return HttpResponseRedirect('manageusers')
        except Exception as e:
            logger.error("Unable to process file. " + repr(e))
            return HttpResponseRedirect('manageusers')

        file_data = csv_file.read().decode("utf-8")

        lines = file_data.split("\n")
        fields = lines[0].split(",")

        # Determine the field order for the CSV
        for i,field in enumerate(fields):
            if field.lower() in self.first_name_opts:
                self.csv_positions['first_name'] = i
            elif field.lower() in self.last_name_opts:
                self.csv_positions['last_name'] = i
            elif field.lower() in self.email_opts:
                self.csv_positions['email'] = i
            elif field.lower() in self.program_opts:
                self.csv_positions['program'] = i
            elif field.lower() in self.country_opts:
                self.csv_positions['country'] = i

        # Validate CSV headers
        if self.csv_positions['email'] < 0:
            return bad_request("Cannot find email in CSV", exception="BadCSV")
        elif self.csv_positions['first_name'] < 0:
            return bad_request("Cannot find first name in CSV", exception="BadCSV")
        elif self.csv_positions['last_name'] < 0:
            return bad_request("Cannot find last name in CSV", exception="BadCSV")
        elif self.csv_positions['program'] < 0:
            return bad_request("Cannot find program in CSV", exception="BadCSV")

        # user = {
        #     'first_name': "",
        #     'last_name': "",
        #     'program': "",
        #     'email': "",
        #     'type': "Student",
        #     'country': "France"
        # }

        for line in lines[1:]:
            user = {}
            if line == "":
                continue

            fields = line.split(',')

            user['first_name'] = fields[self.csv_positions['first_name']]
            user['last_name'] = fields[self.csv_positions['last_name']]
            user['program'] = fields[self.csv_positions['program']]
            user['email'] = fields[self.csv_positions['email']]

            if self.csv_positions['country'] > 0:
                user['country'] = fields[self.csv_positions['country']]
            else:
                user['country'] = "France"

            all_users.append(user)

            print(user)

        logger.info("Processing CSV user file with {} potential users".format(len(all_users)))

        return JsonResponse(all_users, safe=False)



    def get_queryset(self):
        '''
        Queries database for all attendance records for a given schedule ID

        :return: queryset of all attendance records for a particular schedule_id, received from HTTP GET
        '''
        schedule_filter = self.request.query_params.get('schedule_id', )

        if schedule_filter == None:
            return None

        queryset = Attendance.objects.filter(schedule_id=schedule_filter)

        return queryset