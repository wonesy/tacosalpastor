import re

from django.db import models
from django.utils.translation import ugettext as _
from epita.models import Course
from django.utils import timezone
from django.core.exceptions import ValidationError
import decimal

"""
General Quiz Section
"""

class Quiz(models.Model):
    """
    Defines an overall Quiz

    Fields
        title
        description
        utl
        course
        status
        open
        time_limit
        randomize
    """
    DRAFT = 'DRAFT'
    READY = 'READY'
    COMPLETED = 'COMPLETED'
    STATUS_CHOICES = (
        (DRAFT, 'draft'),
        (READY, 'ready'),
        (COMPLETED, 'completed')
    )

    title = models.CharField(verbose_name=_("Title"), max_length=80, blank=False)
    description = models.TextField(verbose_name=_("Description"), blank=True, help_text="description of the quiz")
    url = models.SlugField(max_length=80, blank=False, help_text="a user friendly url", verbose_name=_("User-friendly URL"))
    course = models.ForeignKey(Course, verbose_name=_("Associated Course"), blank=True, null=True, on_delete=models.SET_NULL)
    status = models.CharField(max_length=9, choices=STATUS_CHOICES, default=DRAFT,
                              help_text="the quiz can either be ready to take, completed, or a draft", verbose_name=_("Status"))
    open = models.BooleanField(default=False, verbose_name=_("Open"),
                               help_text="when the quiz is opened, users can begin, otherwise, no answers are accepted")
    time_limit = models.TimeField(null=True, blank=True, verbose_name=_("Time limit"),
                                 help_text="time limit for which quiz will be open")
    randomize = models.BooleanField(default=False, verbose_name=_("Randomize"), help_text="randomize question order")
    created_on = models.DateTimeField(default=timezone.now, blank=False, verbose_name=_("Creation Time"),)

    class Meta:
        verbose_name = _("Quiz")
        verbose_name_plural = _("Quizzes")

    def save(self, force_insert=False, force_update=False, *args, **kwargs):

        if self.url == "":
            tmp = self.title
        else:
            tmp = self.url

        self.url = "{}{}{}{}{}{}-{}".format(self.created_on.microsecond,
                                            self.created_on.second,
                                            self.created_on.minute,
                                            self.created_on.day,
                                            self.created_on.month,
                                            self.created_on.year,
                                            re.sub('\s+', '-', tmp).lower())

        self.url = ''.join(letter for letter in self.url if letter.isalnum() or letter == '-')

        if (self.status is not self.READY) and self.open:
            self.open = False

        super(Quiz, self).save(force_insert, force_update, *args, **kwargs)

    def __str__(self):
        return self.title

    def get_created_date(self):
        return "{}-{}-{}".format(self.created_on.day, self.created_on.month, self.created_on.year)


class Question(models.Model):
    ESSAY = 0
    MULTIPLE_CHOICE = 1
    CHECKBOX = 2
    NUMERIC_SCALE = 3
    QUESTION_TYPES = (
        (ESSAY, "Essay Question"),
        (MULTIPLE_CHOICE, "Multiple Choice Question"),
        (CHECKBOX, "Checkbox Question"),
        (NUMERIC_SCALE, "Numeric Scale Question")
    )
    quiz = models.ManyToManyField(Quiz, verbose_name=_('Quiz'), blank=True)
    content = models.CharField(max_length=1023, verbose_name=_("Question Content"), help_text="the actual question being asked")
    figure = models.ImageField(blank=True, null=True, upload_to="image/quiz", verbose_name=_("Figure"))
    explanation = models.CharField(max_length=1023, verbose_name=_("Explanation"), blank=True,
                                   help_text="Explanation of correct answer to be shown after user submits response")
    type = models.IntegerField(null=False, verbose_name=_("Question Type"), choices=QUESTION_TYPES, default=ESSAY)

    def _str__(self):
        return "[{}] {}".format(self.quiz.id, self.content)


"""

Multiple Choice Section

"""


class MultipleChoiceQuestion(Question):

    randomize = models.BooleanField(default=False, verbose_name=_("Randomize Options"), help_text="randomize the option order")

    def clean(self):
        super(MultipleChoiceQuestion, self).clean()

        if self.type == Question.ESSAY:
            raise ValidationError(_("Cannot be multiple-choice and essay"))

    def check_if_correct(self, guess):
        opt = MultipleChoiceOption.objects.get(id=guess)

        return opt.is_correct

class CheckboxQuestion(MultipleChoiceQuestion):
    multiple_answers = models.BooleanField(default=True, verbose_name=_("Multiple Correct Answers"))
    partial_credit = models.BooleanField(default=False, verbose_name=_("Partial Credit"),
                                         help_text="Allow partial credit for correctly chosen answers, but where not all correct answers were chosen")
    total_correct_answers = models.IntegerField(blank=False, verbose_name=_("Total Correct Answers"), help_text="total number of correct answers")
    incorrect_choice_points_lost = models.DecimalField(max_digits=4, decimal_places=2, default=1, verbose_name=_("Incorrect Choice Points Lost"),
                                                       help_text="the number of points lost for an incorrect choice")
    missed_choice_points_lost = models.DecimalField(max_digits=4, decimal_places=2, default=0, verbose_name=_("Missed Choice Points Lost"),
                                                    help_text="the number of points lost for a correct choice that's missed")
    allow_negative_score = models.BooleanField(default=False, verbose_name=_("Allow Negative Scores"), help_text="allow negative scores")

    def clean(self):
        super(CheckboxQuestion, self).clean()

        if MultipleChoiceOption.objects.get(question=self) < self.total_correct_answers:
            raise ValidationError

    def get_score(self, guesses):
        correct_answers_submitted = 0
        score = 0

        correct_answers = MultipleChoiceOption.objects.filter(question=self, is_correct=True)

        # Calculate the number of correct guesses, and subtract incorrect choice points
        for guess in guesses:
            if guess in correct_answers:
                correct_answers_submitted+=1
                score += 1
            else:
                score -= self.incorrect_choice_points_lost

        # Calculate the number of missed correct answers, and subtract points accordingly
        correct_answers_difference = self.total_correct_answers - correct_answers_submitted
        score -= (correct_answers_difference * self.missed_choice_points_lost)

        if score < 0 and not self.allow_negative_score:
            score = 0

        return score

class MultipleChoiceOption(models.Model):

    question = models.ForeignKey(MultipleChoiceQuestion, verbose_name=_("Multiple Choice Question"), on_delete=models.CASCADE, null=False, blank=False)
    content = models.CharField(max_length=1024, blank=False, help_text="Enter the text you want displayed as an MC option")
    is_correct = models.BooleanField(default=False, blank=False, help_text="Is this the correct answer to the question?")

    def __str__(self):
        return self.content

    class Meta:
        verbose_name = _("Option")
        verbose_name_plural = _("Options")

"""

Numeric Scale Question

[1] [2] [3] [4] [5]

"""
class NumericScaleQuestion(Question):
    min = models.IntegerField(verbose_name=_("Minimum Scale Value"), blank=False)
    max = models.IntegerField(verbose_name=_("Maximum Scale Value"), blank=False)
    step = models.IntegerField(verbose_name=_("Step Value"), default=1)
    correct_value = models.IntegerField(verbose_name=_("Correct Value"), blank=True, null=True)

    def clean(self):
        super(NumericScaleQuestion, self).clean()

        if self.type == Question.ESSAY:
            raise ValidationError(_("Cannot be both numeric-scale and essay"))

        # Reverse the order of min/max if step is negative
        if self.step < 0:
            tmp = self.min
            self.min = self.max
            self.max = tmp
            self.step *= -1

        if self.min >= self.max:
            raise ValidationError(_("Min cannot be greater-than or equal to max"))