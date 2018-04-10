from django import forms
from quiz.models import MultipleChoiceQuestion, MultipleChoiceOption

class MultipleChoiceForm(forms.ModelForm):
    class Meta:
        model = MultipleChoiceQuestion
        fields = ['content', 'explanation', 'randomize']

class MultipleChoiceOptionForm(forms.ModelForm):
    class Meta:
        model = MultipleChoiceOption
        fields = ['content', 'is_correct']
