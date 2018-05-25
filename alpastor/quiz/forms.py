from django import forms
from quiz.models import MultipleChoiceQuestion, MultipleChoiceOption, Question, Quiz


class QuizForm(forms.ModelForm):
    class Meta:
        model = Quiz
        fields = ['title', 'description', 'course', 'randomize']


class MultipleChoiceForm(forms.ModelForm):
    type = forms.IntegerField(initial=Question.MULTIPLE_CHOICE, widget=forms.HiddenInput)

    class Meta:
        model = MultipleChoiceQuestion
        fields = ['content', 'explanation', 'randomize']


class MultipleChoiceOptionForm(forms.ModelForm):
    class Meta:
        model = MultipleChoiceOption
        fields = ['content', 'is_correct']
