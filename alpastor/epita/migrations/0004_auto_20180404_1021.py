# Generated by Django 2.0.2 on 2018-04-04 10:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('epita', '0003_auto_20180402_1054'),
    ]

    operations = [
        migrations.AddField(
            model_name='attendance',
            name='file_upload',
            field=models.FileField(blank=True, null=True, upload_to=''),
        ),
        migrations.AddField(
            model_name='attendance',
            name='upload_time',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
