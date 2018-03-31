# Generated by Django 2.0.2 on 2018-04-02 10:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('quiz', '0002_auto_20180328_1319'),
    ]

    operations = [
        migrations.CreateModel(
            name='CheckboxQuestion',
            fields=[
                ('multiplechoicequestion_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='quiz.MultipleChoiceQuestion')),
                ('multiple_answers', models.BooleanField(default=True, verbose_name='Multiple Correct Answers')),
                ('partial_credit', models.BooleanField(default=False, help_text='Allow partial credit for correctly chosen answers, but where not all correct answers were chosen', verbose_name='Partial Credit')),
                ('total_correct_answers', models.IntegerField(help_text='total number of correct answers', verbose_name='Total Correct Answers')),
                ('incorrect_choice_points_lost', models.DecimalField(decimal_places=2, default=1, help_text='the number of points lost for an incorrect choice', max_digits=4, verbose_name='Incorrect Choice Points Lost')),
                ('missed_choice_points_lost', models.DecimalField(decimal_places=2, default=0, help_text="the number of points lost for a correct choice that's missed", max_digits=4, verbose_name='Missed Choice Points Lost')),
                ('allow_negative_score', models.BooleanField(default=False, help_text='allow negative scores', verbose_name='Allow Negative Scores')),
            ],
            bases=('quiz.multiplechoicequestion',),
        ),
        migrations.CreateModel(
            name='NumericScaleQuestion',
            fields=[
                ('question_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='quiz.Question')),
                ('min', models.IntegerField(verbose_name='Minimum Scale Value')),
                ('max', models.IntegerField(verbose_name='Maximum Scale Value')),
                ('step', models.IntegerField(default=1, verbose_name='Step Value')),
                ('correct_value', models.IntegerField(blank=True, verbose_name='Correct Value')),
            ],
            bases=('quiz.question',),
        ),
        migrations.AddField(
            model_name='question',
            name='essay',
            field=models.BooleanField(default=False, verbose_name='Open-Ended Essay Question'),
        ),
    ]