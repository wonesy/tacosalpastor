# Generated by Django 2.0.2 on 2018-03-28 12:56

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('quiz', '0001_initial_squashed_0005_auto_20180328_1242'),
    ]

    operations = [
        migrations.AlterField(
            model_name='quiz',
            name='created_on',
            field=models.DateTimeField(default=datetime.datetime(2018, 3, 28, 12, 56, 54, 157847, tzinfo=utc), verbose_name='Creation Time'),
        ),
    ]