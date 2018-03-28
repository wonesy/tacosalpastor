from django.test import TestCase
import re
from .models import Quiz, Question, MultipleChoiceQuestion, MultipleChoiceOption

# Create your tests here.
class MultipleChoiceTest(TestCase):
    def setUp(self):
        self.quiz1 = Quiz.objects.create(title="EPITA test multiple-choice quiz")
        self.quiz2 = Quiz.objects.create(title="EPITA test multiple-choice quiz")

        self.mcquestion = MultipleChoiceQuestion.objects.create(content="Do you capitalize the first letter of a job title?",
                                                                explanation="Absolutely not, you must be dumb")
        self.mcquestion.quiz.add(self.quiz1)
        self.mcquestion.quiz.add(self.quiz2)

        self.option1 = MultipleChoiceOption.objects.create(question=self.mcquestion,
                                                           content="Yes",
                                                           is_correct=False)

        self.option2 = MultipleChoiceOption.objects.create(question=self.mcquestion,
                                                           content="No",
                                                           is_correct=True)

    def test_mcquiz_quiz_exists(self):
        self.assertTrue(Quiz.objects.exists())

    def test_mcquiz_question_exists(self):
        self.assertTemplateNotUsed(MultipleChoiceQuestion.objects.exists())

    def test_mcquiz_2_options(self):
        self.assertEqual(2, MultipleChoiceOption.objects.filter(question=self.mcquestion).count())

    def test_mcquiz_unique_url(self):
        url1 = "{}{}{}{}{}{}-{}".format(self.quiz1.created_on.microsecond,
                                        self.quiz1.created_on.second,
                                        self.quiz1.created_on.minute,
                                        self.quiz1.created_on.day,
                                        self.quiz1.created_on.month,
                                        self.quiz1.created_on.year,
                                        re.sub('\s+', '-', self.quiz1.title).lower())

        url2 = "{}{}{}{}{}{}-{}".format(self.quiz2.created_on.microsecond,
                                        self.quiz2.created_on.second,
                                        self.quiz2.created_on.minute,
                                        self.quiz2.created_on.day,
                                        self.quiz2.created_on.month,
                                        self.quiz2.created_on.year,
                                        re.sub('\s+', '-', self.quiz2.title).lower())

        self.assertNotEqual(self.quiz1.url, self.quiz2.url)

        self.assertEqual(self.quiz1.url, url1)
        self.assertEqual(self.quiz2.url, url2)

    def test_mcquiz_manytomany(self):
        mcq1 = Question.objects.filter(quiz=self.quiz1)
        mcq2 = Question.objects.filter(quiz=self.quiz2)

        self.assertQuerysetEqual(mcq2, mcq1, transform=lambda x: x)
