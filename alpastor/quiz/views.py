from django.shortcuts import render, redirect
from quiz.models import Quiz, Question, MultipleChoiceOption, MultipleChoiceQuestion, NumericScaleQuestion
from epita.models import Course
from django.views import View
from quiz.forms import MultipleChoiceForm, MultipleChoiceOptionForm
from quiz.serializers import QuestionSerializer
from rest_framework import generics
from rest_framework.response import Response
import json
import enum

class QuizErrors(enum.Enum):
    NOTITLE = 1

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
            return QuizErrors.NOTITLE

        # Create the new quiz object in the database
        (quiz, created) = Quiz.objects.get_or_create(title=quiz_title)

        # Process every question for this quiz
        for question in quiz_json['questions']:
            self.processQuestionJSON(quiz, question)

        return 0

    def processQuestionJSON(self, quiz, question_json):

        question_type = question_json['type']
        question_content = question_json['content']
        question_explanation = question_json['explanation']
        question_randomize = question_json['randomize']

        defaults = {
            'explanation': question_explanation,
            'randomize': question_randomize
        }

        '''
        Create new question database instance. The consequence of using update_or_create in this manner is that we cannot
        have two questions of the same type with the exact same title. If a new question is added with the same type & content,
        the old one will instead just be updated.
        '''

        if question_type == str(Question.MULTIPLE_CHOICE):
            (question, created) = MultipleChoiceQuestion.objects.update_or_create(content=question_content, type=question_type, defaults=defaults)

            if created:
                print("Created new question: {}".format(question))
            else:
                print("Updated existing question: {}".format(question))

            # Process every option for this question
            for option in question_json['options']:
                self.processOptionJSON(question, option)


    def processOptionJSON(self, question, option_json):
        opt_content = option_json['content']
        if option_json['is_correct'] in ['true', 'True', 'TRUE']:
            opt_is_correct = True
        else:
            opt_is_correct = False


        '''
        We are doing get_or_create rather than update_or_create because the same option might exist but for a different
        question. Question is just a FK (not a ManyToMany) so we want those two potentially identical options to be saved
        separately in the database
        '''

        (option, created) = MultipleChoiceOption.objects.get_or_create(question=question,
                                                                       content=opt_content,
                                                                       is_correct=opt_is_correct)

        if created:
            print("Created new option: {}".format(option))
        else:
            print("Accessed existing option: {}".format(option))

class AddExistingQuestionView(generics.ListCreateAPIView):
    serializer_class = QuestionSerializer
    queryset = MultipleChoiceOption.objects.all()

    def get(self, request):
        questions = self.get_queryset()
        serializers = QuestionSerializer(questions, many=True)
        return Response(serializers.data)

    def get_queryset(self):
        content_filter = self.request.query_params.get('content', None)
        type_filter = self.request.query_params.get('type', None)

        if content_filter == None:
            return None

        if type_filter == None:
            queryset = Question.objects.filter(content__icontains=content_filter)
        else:
            queryset = Question.objects.filter(content__icontains=content_filter, type=type_filter)

        if type_filter != None:
            queryset.filter(type__exact=type_filter)

        return queryset

    def perform_create(self, serializer):
        """ Save the POST data """
        serializer.save()


class EditQuizPage(View):
    template_name = "edit_quiz.html"

    def post(self, request):
        pass

    def get(self, request):
        return render(request, "edit_quiz.html")

    def get_queryset(self):
        return Quiz.objects.all()

def quizHomePage(request):
    quizzes = Quiz.objects.all()
    return render(request, "quiz.html", {'quizzes': quizzes})
"""
class SearchCourse:

    def get_queryset(self):
        result = super(SearchCourse, self).get_queryset()

        query = self.request.GET.get('q')
        if query:
            query_list = query.split()
            result = result.filter(
                reduce(operator.and_(Quiz(title_icontains=q) for q in query_list)) |
                reduce(operator.and_(Quiz(course_icontains=q) for q in query_list))
            )

            return result
"""