from django.shortcuts import render
from epita.models import Course
from django.views import View
from .forms import MultipleChoiceForm

# Create your views here.
#@login_required()
class QuizBuilderView(View):
    template_name = "quiz_builder.html"
    model = Course

    def post(self, request):
        pass

    def get(self, request):
        mcform = MultipleChoiceForm()
        print("Here")
        print(mcform)
        return render(request, self.template_name, {'mcform': mcform})

    def get_queryset(self):
        return Course.objects.all()
