# Generated by Django 2.0.2 on 2018-04-02 10:54

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('epita', '0002_auto_20180402_0903'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='attendance',
            name='file_upload',
        ),
        migrations.RemoveField(
            model_name='attendance',
            name='upload_time',
        ),
    ]
