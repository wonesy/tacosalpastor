from rest_framework import serializers
from quiz.models import *

class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ['content', 'type', 'figure', 'explanation']