from django.shortcuts import render, redirect
from quiz.models import Quiz, Question, MultipleChoiceOption, MultipleChoiceQuestion, NumericScaleQuestion
from django.views import View
from quiz.serializers import QuestionSerializer, QuizSerializer
from rest_framework import generics
from rest_framework.response import Response
import json
import enum

class QuizStatusCodes(enum.Enum):
    SUCCESS = 0,
    NOTITLE = 1,
    BADID = 2

class QuizBuilderView(View):
    template_name = "quiz_builder.html"
    model = Quiz

    def post(self, request):
        return render(request, self.template_name)

    def get(self, request):
        quiz_id = request.GET.get('quiz_id', '')
        return render(request, self.template_name)

class SaveNewQuiz(View):
    def get(self, request):
        return redirect('quiz_home_page')

    def post(self, request):
        quiz_payload = json.loads(request.POST['json_quiz'])

        if self.processQuizJSON(quiz_payload):
            return redirect('quizbuilder')

        return redirect('quiz_home_page')


    def processQuizJSON(self, quiz_json):
        quiz_id = quiz_json['id']
        quiz_title = quiz_json['title']

        if quiz_title == "":
            print("[FAIL] quiz must have a title")
            return QuizStatusCodes.NOTITLE

        # Create the new quiz object in the database, or update title if already exists
        try:
            (quiz, created) = Quiz.objects.update_or_create(id=int(quiz_id), defaults={'title': quiz_title})
        except ValueError:
            print("Invalid Quiz Id: {}".format(quiz_id))
            return QuizStatusCodes.BADID

        if created:
            print("Created new quiz with title: " + quiz.title)
        else:
            print("Accessed existing quiz with title: " + quiz.title)

        # Process every question for this quiz
        for question in quiz_json['questions']:
            self.processQuestionJSON(quiz, question)

        return QuizStatusCodes.SUCCESS

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

            # Process every option for this question
            for option in question_json['options']:
                self.processOptionJSON(question, option)

        elif question_type == str(Question.ESSAY):
            (question, created) = Question.objects.update_or_create(content=question_content, type=question_type, defaults={'explanation': question_explanation})

        elif question_type == str(Question.NUMERIC_SCALE):
            (question, created) = NumericScaleQuestion.objects.update_or_create(content=question_content, type=question_type,defaults={'explanation': question_explanation})

        else:
            created = False
            question = None

        if question:
            question.quiz.add(quiz)

        if created:
            print("Created new question: {}".format(question))
        elif question:
            print("Updated existing question: {}".format(question))
        else:
            print("No question was created, something went wrong")


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

class GetQuizData(generics.ListCreateAPIView):
    serializer_class = QuestionSerializer
    queryset = MultipleChoiceOption.objects.all()

    def get(self, request, **kwargs):
        quiz_filter = self.request.query_params.get('quiz_id', None)
        qs = self.get_queryset()

        if quiz_filter:
            serializers = QuizSerializer(qs, many=True)
        else:
            serializers = QuestionSerializer(qs, many=True)
        return Response(serializers.data)

    def get_queryset(self):
        quiz_filter = self.request.query_params.get('quiz_id', None)
        content_filter = self.request.query_params.get('content', None)
        type_filter = self.request.query_params.get('type', None)

        # If this is an attempt to get all questions for a quiz, return immediately
        if quiz_filter:
            queryset = Quiz.objects.filter(pk=quiz_filter)
            return queryset

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