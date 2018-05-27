from rest_framework import serializers
from quiz.models import *

class OptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = MultipleChoiceOption
        fields = ['content', 'is_correct']

class QuestionSerializer(serializers.ModelSerializer):
    multiplechoiceoption_set = OptionSerializer(many=True, read_only=True)
    class Meta:
        model = Question
        fields = ['content', 'type', 'figure', 'explanation', 'multiplechoiceoption_set']

