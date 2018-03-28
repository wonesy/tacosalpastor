import re
import pytz

from django.db import models
from django.utils.translation import ugettext as _
from epita.models import Course
from django.utils import timezone

"""
General Quiz Section
"""

class Quiz(models.Model):
    """
    Defines an overall Quiz

    Fieldsz:
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

        if self.status is not self.READY and self.open:
            self.open = False

        super(Quiz, self).save(force_insert, force_update, *args, **kwargs)

    def __str__(self):
        return self.title

    def get_created_date(self):
        return "{}-{}-{}".format(self.created_on.day, self.created_on.month, self.created_on.year)


class Question(models.Model):
    quiz = models.ManyToManyField(Quiz, verbose_name=_('Quiz'), blank=True)
    content = models.CharField(max_length=1023, verbose_name=_("Question Content"), help_text="the actual question being asked")
    figure = models.ImageField(blank=True, null=True, upload_to="image/quiz", verbose_name=_("Figure"))
    explanation = models.CharField(max_length=1023, verbose_name=_("Explanation"), blank=True,
                                   help_text="Explanation of correct answer to be shown after user submits response")


"""

Multiple Choice Section

"""


class MultipleChoiceQuestion(Question):

    randomize = models.BooleanField(default=False, verbose_name=_("Randomize Options"), help_text="randomize the option order")

    def check_if_correct(self, guess):
        opt = MultipleChoiceOption.objects.get(id=guess)

        return opt.is_correct

class MultipleChoiceOption(models.Model):

    question = models.ForeignKey(MultipleChoiceQuestion, verbose_name=_("Multiple Choice Question"), on_delete=models.CASCADE, null=False, blank=False)
    content = models.CharField(max_length=1024, blank=False, help_text="Enter the text you want displayed as an MC option")
    is_correct = models.BooleanField(default=False, blank=False, help_text="Is this the correct answer to the question?")

    def __str__(self):
        return self.content

    class Meta:
        verbose_name = _("Option")
        verbose_name_plural = _("Options")




