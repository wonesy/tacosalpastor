from django.shortcuts import render, redirect
from django.contrib.auth import logout
from django.contrib.auth import login as auth_login
from django.http import HttpResponseRedirect
from .forms import LoginForm

# Create your views here.
def login(request):
    logout(request)
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            auth_login(request, form.get_user())
            return redirect('home')
    else:
        form = LoginForm()

    return render(request, 'login.html', {'form': form})