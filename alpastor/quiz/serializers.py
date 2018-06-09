from rest_framework import serializers
from quiz.models import Question, MultipleChoiceOption, Quiz

class OptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = MultipleChoiceOption
        fields = ['id', 'content', 'is_correct']

class QuestionSerializer(serializers.ModelSerializer):
    multiplechoiceoption_set = OptionSerializer(many=True, read_only=True)
    class Meta:
        model = Question
        fields = ['id', 'content', 'type', 'figure', 'explanation', 'multiplechoiceoption_set']

class QuizSerializer(serializers.ModelSerializer):
    question_set = QuestionSerializer(many=True, read_only=True)
    course_title = serializers.SerializerMethodField()
    class Meta:
        model = Quiz
        fields = ['title', 'course', 'course_title', 'description', 'question_set']

    def get_course_title(self, obj):
        if obj.course != None:
            return obj.course.verbose_title()

