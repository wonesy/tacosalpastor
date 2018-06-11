from django.shortcuts import render, redirect
from django.contrib.auth import logout
from django.contrib.auth import login as auth_login
from django.contrib.auth.decorators import user_passes_test
from accounts.forms import LoginForm
from epita.models import Student

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
        'specializations': Student.get_non_none_specialization_choices(None),
    })