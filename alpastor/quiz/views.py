from django.shortcuts import render, redirect
from epita.models import Course
from django.views import View
from .forms import MultipleChoiceForm, MultipleChoiceOptionForm
import json

# Create your views here.
#@login_required()
class QuizBuilderView(View):
    template_name = "quiz_builder.html"
    model = Course

    def post(self, request):
        pass

    def get(self, request):
        mcform = MultipleChoiceForm()
        mcoptform = MultipleChoiceOptionForm()

        dict = {
            'mcform': mcform,
            'mcoptform': mcoptform
        }

        return render(request, self.template_name, dict)

    def get_queryset(self):
        return Course.objects.all()

def saveNewQuiz(request):
    if request.method != "POST":
        return redirect('quizbuilder')

    print(request.POST)
    return redirect('quizbuilder')