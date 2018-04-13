from django.contrib import admin
from quiz.models import *

# Register your models here.
admin.site.register(Quiz)
admin.site.register(Question)
admin.site.register(MultipleChoiceQuestion)
admin.site.register(NumericScaleQuestion)
admin.site.register(MultipleChoiceOption)

