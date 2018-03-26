from django.test import TestCase
from epita.models import Student
from django.urls import reverse, resolve

class PeopleTests(TestCase):
    def setUp(self):
        url = reverse('people')
        self.response = self.client.get(url)

    def test_people_status_code(self):
        """
        This will have to change when we enable @login_required
        :return:
        """
        self.assertEqual(self.response.status_code, 200)
