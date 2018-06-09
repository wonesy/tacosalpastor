from django.core.management.base import BaseCommand
from accounts.models import User


class Command(BaseCommand):

    def handle(self, *args, **options):
        if not User.objects.filter(email="admin@epita.fr",).exists():
            User.objects.create_superuser(email="admin@epita.fr", password="admin")
