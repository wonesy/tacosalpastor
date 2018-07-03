from django.test import TestCase
from django.urls import reverse, resolve
from .views import login
from .forms import LoginForm
from .models import User

# Create your tests here.
class LoginTests(TestCase):
    """
    Tests for the general workings of the view and url actions
    """
    def setUp(self):
        url = reverse('login')
        self.response = self.client.get(url)

    def test_login_status_code(self):
        self.assertEqual(self.response.status_code, 200)

    def test_login_url_resolves_signup_view(self):
        view = resolve('/login/')
        self.assertEquals(view.func, login)

    def test_login_csrf(self):
        self.assertContains(self.response, 'csrfmiddlewaretoken')

    def test_login_contains_form(self):
        form = self.response.context.get('form')
        self.assertIsInstance(form, LoginForm)

class SuccessfulLoginTests(TestCase):
    """
    Specific testing for a successful log on
    """
    def setUp(self):
        self.user = User.objects.create(email='testuser@epita.fr', is_registered=True)
        self.user.set_password('abcdef123456')
        self.user.save()

        self.url = reverse('login')
        self.data = {
            'username': 'testuser@epita.fr',
            'password': 'abcdef123456'
        }

        self.response = self.client.post(self.url, self.data)
        self.home_url = reverse('home')

    def test_successful_login_user_creation(self):
        self.assertTrue(User.objects.exists())

    def test_successful_login_redirection(self):
        '''
        A valid form submission should redirect the user to the home page
        '''
        self.assertRedirects(self.response, self.home_url)

    def test_successful_login_user_auth(self):
        response = self.client.get(self.home_url)
        user = response.context.get('user')
        self.assertTrue(user.is_authenticated)

class InvalidLoginTests(TestCase):
    def setUp(self):
        url = reverse('login')
        self.response = self.client.post(url, {})  # submit an empty dictionary

    def test_invalid_login_signup_status_code(self):
        '''
        An invalid form submission should return to the same page
        '''
        self.assertEquals(self.response.status_code, 200)

    def test_invalid_login_form_errors(self):
        form = self.response.context.get('form')
        self.assertTrue(form.errors)

    def test_invalid_login_no_user(self):
        self.assertFalse(User.objects.exists())