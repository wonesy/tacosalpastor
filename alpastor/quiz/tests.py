from django.core.exceptions import ValidationError
from django.test import TestCase
from quiz.models import Quiz, MultipleChoiceQuestion, MultipleChoiceOption, NumericScaleQuestion, Question

# Create your tests here.
class MultipleChoiceTest(TestCase):
    def setUp(self):
        self.quiz1 = Quiz.objects.create(title="EPITA test multiple-choice quiz")
        self.quiz2 = Quiz.objects.create(title="EPITA test multiple-choice quiz")

        self.mcquestion = MultipleChoiceQuestion.objects.create(content="Do you capitalize the first letter of a job title?",
                                                                explanation="Absolutely not, you must be dumb",
                                                                type=Question.MULTIPLE_CHOICE)
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
        self.assertTrue(MultipleChoiceQuestion.objects.exists())

    def test_mcquiz_2_options(self):
        self.assertEqual(2, MultipleChoiceOption.objects.filter(question=self.mcquestion).count())

    def test_mcquiz_unique_url(self):
        self.assertNotEqual(self.quiz1.url, self.quiz2.url)


    def test_mcquiz_manytomany(self):
        mcq1 = Question.objects.filter(quiz=self.quiz1)
        mcq2 = Question.objects.filter(quiz=self.quiz2)

        self.assertQuerysetEqual(mcq2, mcq1, transform=lambda x: x)

class NumericScaleTest(TestCase):
    def setUp(self):
        self.quiz = Quiz.objects.create(title="Numeric Quiz Example")
        self.numeric_question = NumericScaleQuestion.objects.create(content="Rate me", min=1, max=10, step=1, type=Question.NUMERIC_SCALE)
        self.numeric_question.quiz.add(self.quiz)

    def test_numericscale_quiz_exists(self):
        self.assertTrue(NumericScaleQuestion.objects.exists())

    def test_numericscale_negative_step(self):
        negative_question = NumericScaleQuestion.objects.create(content="Negative Numeric", min=100, max=10, step=-1, type=Question.NUMERIC_SCALE)
        negative_question.clean()
        self.assertEqual(negative_question.min, 10)
        self.assertEqual(negative_question.max, 100)
        self.assertEqual(negative_question.step, 1)

    def test_numericscale_range_error(self):
        self.assertRaises(ValidationError, lambda: NumericScaleQuestion.objects.create(content="Invalid", min=1, max=1, type=Question.NUMERIC_SCALE).clean())

# class CheckboxTest(TestCase):
#     def setUp(self):
#         self.question = CheckboxQuestion.objects.create(content="Which are members of wu-tang", total_correct_answers=2, type=Question.MULTIPLE_CHOICE)
#         self.opt1 = MultipleChoiceOption.objects.create(question=self.question, content="Method Man", is_correct=True)
#         self.opt2 = MultipleChoiceOption.objects.create(question=self.question, content="Jay Z", is_correct=False)
#         self.opt3 = MultipleChoiceOption.objects.create(question=self.question, content="Nas", is_correct=False)
#         self.opt4 = MultipleChoiceOption.objects.create(question=self.question, content="GZA", is_correct=True)
#
#     def test_checkbox_question_exists(self):
#         self.assertTrue(CheckboxQuestion.objects.exists())
#
#     def test_checkbox_correct_score(self):
#
#         # All Correct
#         submission = [self.opt1, self.opt4]
#         self.assertEqual(2, self.question.get_score(submission))
#
#         # One Missed
#         submission = [self.opt1]
#         self.assertEqual(1, self.question.get_score(submission))
#
#         # One Missed, One Wrong
#         submission = [self.opt3, self.opt4]
#         self.assertEqual(0, self.question.get_score(submission))
#
#         # All Wrong
#         submission = [self.opt2, self.opt3]
#         self.assertEqual(0, self.question.get_score(submission))
#
#         # All Answers
#         submission = [self.opt1, self.opt2, self.opt3, self.opt4]
#         self.assertEqual(0, self.question.get_score(submission))
#
#     def test_checkbox_correct_negative_score(self):
#         neg_question = CheckboxQuestion.objects.create(content="Which are colors", total_correct_answers=2, allow_negative_score=True, type=Question.MULTIPLE_CHOICE)
#         negopt1 = MultipleChoiceOption.objects.create(question=neg_question, content="Blue", is_correct=True)
#         negopt2 = MultipleChoiceOption.objects.create(question=neg_question, content="Joe", is_correct=False)
#         negopt3 = MultipleChoiceOption.objects.create(question=neg_question, content="5", is_correct=False)
#         negopt4 = MultipleChoiceOption.objects.create(question=neg_question, content="Purple", is_correct=True)
#
#         # All Correct
#         submission = [negopt1, negopt4]
#         self.assertEqual(2, neg_question.get_score(submission))
#
#         # One Missed
#         submission = [negopt1]
#         self.assertEqual(1, neg_question.get_score(submission))
#
#         # One Missed, One Wrong
#         submission = [negopt3, negopt4]
#         self.assertEqual(0, neg_question.get_score(submission))
#
#         # All Wrong
#         submission = [self.opt2, self.opt3]
#         self.assertEqual(-2, neg_question.get_score(submission))
#
#         # All Answers
#         submission = [negopt1, negopt2, negopt3, negopt4]
#         self.assertEqual(0, neg_question.get_score(submission))
#
#     def test_checkbox_correct_decimal_scores(self):
#         neg_question = CheckboxQuestion.objects.create(content="Which are colors", total_correct_answers=2,
#                                                        allow_negative_score=True, incorrect_choice_points_lost=0.5, missed_choice_points_lost=0.25,
#                                                        type=Question.MULTIPLE_CHOICE)
#         negopt1 = MultipleChoiceOption.objects.create(question=neg_question, content="Blue", is_correct=True)
#         negopt2 = MultipleChoiceOption.objects.create(question=neg_question, content="Joe", is_correct=False)
#         negopt3 = MultipleChoiceOption.objects.create(question=neg_question, content="5", is_correct=False)
#         negopt4 = MultipleChoiceOption.objects.create(question=neg_question, content="Purple", is_correct=True)
#
#         # All Correct (1 + 1)
#         submission = [negopt1, negopt4]
#         self.assertEqual(2, neg_question.get_score(submission))
#
#         # One Missed (1 - 0.25)
#         submission = [negopt1]
#         self.assertEqual(0.75, neg_question.get_score(submission))
#
#         # One Missed, One Wrong (1 - 0.25 - 0.5)
#         submission = [negopt3, negopt4]
#         self.assertEqual(0.25, neg_question.get_score(submission))
#
#         # All Wrong (-0.5 - 0.5 - 0.25 - 0.25)
#         submission = [self.opt2, self.opt3]
#         self.assertEqual(-1.5, neg_question.get_score(submission))
#
#         # All Answers (1 + 1 - 0.5 - 0.5)
#         submission = [negopt1, negopt2, negopt3, negopt4]
#         self.assertEqual(1, neg_question.get_score(submission))