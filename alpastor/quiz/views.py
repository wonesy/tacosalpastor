from django.shortcuts import render, redirect
from quiz.models import Quiz, Question, MultipleChoiceOption, MultipleChoiceQuestion, NumericScaleQuestion
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

class SaveNewQuiz(View):
    def get(self, request):
        return redirect('quizbuilder')

    def post(self, request):
        quiz_payload = json.loads(request.POST['json_quiz'])

        if self.processQuizJSON(quiz_payload):
            return redirect('quizbuilder')

        # TODO redirect to quiz list that dodo is working on
        return redirect('quizbuilder')

    def processQuizJSON(self, quiz_json):
        quiz_title = quiz_json['title']

        if quiz_title == "":
            print("[FAIL] quiz must have a title")
            return 1

        for question in quiz_json['questions']:
            print(question)

        return 0
