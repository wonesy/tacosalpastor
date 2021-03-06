from django.shortcuts import render, redirect
from django.http import HttpResponseBadRequest, HttpResponseForbidden
from quiz.models import Quiz, Question, MultipleChoiceOption, MultipleChoiceQuestion, NumericScaleQuestion, Course
from django.views import View
from quiz.serializers import QuestionSerializer, QuizSerializer
from rest_framework import generics
from rest_framework.response import Response
import json
import enum
import logging

logger = logging.getLogger(__name__)

class QuizStatusCodes(enum.Enum):
    SUCCESS = 0,
    NOTITLE = 1,
    BADID = 2

class QuizBuilderView(View):
    template_name = "quiz/quiz_builder.html"
    model = Quiz

    def post(self, request):
        logger.error("Attempted POST into quiz builder view")
        return HttpResponseBadRequest()

    def get(self, request):
        if request.user.is_superuser:
            course_list = Course.objects.all().order_by('title')
        elif request.user.is_staff:
            course_list = Course.objects.filter(professor_id__user=request.user).order_by('title')
        else:
            logger.error("Attempted access to quiz builder by non staff/admin")
            return HttpResponseForbidden()

        return render(request, self.template_name, {'course_list': course_list})

class SaveNewQuiz(View):
    def get(self, request):
        return redirect('quiz_home_page')

    def post(self, request):
        quiz_payload = json.loads(request.POST['json_quiz'])

        if self.processQuizJSON(quiz_payload) != QuizStatusCodes.SUCCESS:
            return redirect('quizbuilder')

        return redirect('quiz_home_page')


    def processQuizJSON(self, quiz_json):
        try:
            quiz_id = int(quiz_json['id'])
            quiz_course_id = int(quiz_json['courseId'])
        except ValueError:
            logger.error("Invalid Quiz/Course Id with attempting to save a quiz")
            return QuizStatusCodes.BADID

        quiz_title = quiz_json['title']

        if quiz_title == "":
            logger.error("Attempted to save a quiz with no title")
            return QuizStatusCodes.NOTITLE

        # Create the new quiz object in the database, or update title if already exists

        created = False
        if quiz_id < 0:
            logger.debug("Creating new quiz with title={}".format(quiz_title))
            quiz = Quiz.objects.create(title=quiz_title, course_id=quiz_course_id)
        else:
            logger.debug("Updating existing quiz with title={}".format(quiz_title))
            (quiz, created) = Quiz.objects.update_or_create(
                id=quiz_id,
                defaults={'title': quiz_title, 'course_id': quiz_course_id}
            )

        # Process every question for this quiz
        for question in quiz_json['questions']:
            self.processQuestionJSON(quiz, question)

        return QuizStatusCodes.SUCCESS

    def processQuestionJSON(self, quiz, question_json):
        created = False
        question = None
        question_type = question_json['type']
        question_content = question_json['content']
        question_explanation = question_json['explanation']
        question_randomize = ""

        if question_type == Question.MULTIPLE_CHOICE:
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

        if question_type == Question.MULTIPLE_CHOICE:
            (question, created) = MultipleChoiceQuestion.objects.update_or_create(
                content=question_content,
                type=question_type,
                defaults=defaults
            )

            # Process every option for this question
            for option in question_json['options']:
                self.processOptionJSON(question, option)

        elif question_type == Question.ESSAY:
            (question, created) = Question.objects.update_or_create(
                content=question_content,
                type=question_type,
                defaults={'explanation': question_explanation}
            )

        elif question_type == Question.NUMERIC_SCALE:
            (question, created) = NumericScaleQuestion.objects.update_or_create(
                content=question_content,
                type=question_type,
                defaults={'explanation': question_explanation}
            )

        if question:
            question.quiz.add(quiz)

        if created:
            logger.debug("Created new question: {}".format(question))
        elif question:
            logger.debug("Updated existing question: {}".format(question))
        else:
            logger.error("No question was created, something went wrong")


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
            logger.debug("Created new option: {}".format(option))
        else:
            logger.debug("Accessed existing option: {}".format(option))

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


def quizHomePage(request):
    quizzes = Quiz.objects.all()
    return render(request, "quiz/quiz.html", {'quizzes': quizzes})


def delete(request,quiz_id =None):
    object = Quiz.objects.get(id=quiz_id)
    object.delete()
    return render(request, 'quiz/quiz.html')