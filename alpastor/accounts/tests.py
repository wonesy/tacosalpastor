from django.test import TestCase
from django.urls import reverse, resolve
from .views import login
from .forms import LoginForm
from .models import User, ResetToken
from django.utils import timezone

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
        self.user = User.objects.create(email='testuser@epita.fr', is_registered=True, is_staff=True)
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

class ValidRegistrationTests(TestCase):
    def setUp(self):
        self.email = "testemail@epita.fr"
        self.user = User.objects.create_user(email=self.email, password="1234", is_registered=False)
        self.url = reverse('genreset')
        self.data = {
            'email': self.email
        }
        self.response = self.client.post(self.url, self.data)

    def test_valid_registration_status_code(self):
        self.assertEqual(self.response.status_code, 200)

    def test_valid_registration_user_unregistered(self):
        self.assertFalse(self.user.is_registered)

    def test_valid_registration_token_exists(self):
        tokens = ResetToken.objects.filter(user=self.user)
        self.assertEqual(1, tokens.count())

    def test_valid_registration_token_resets(self):
        # send another post, the token should be different
        token = ResetToken.objects.get(user=self.user)
        self.response = self.client.post(self.url, self.data)
        newToken = ResetToken.objects.filter(user=self.user)

        self.assertEqual(1, newToken.count())
        self.assertNotEqual(token.token, newToken[0].token)

    def test_valid_registration_get_token_works(self):
        token = ResetToken.objects.get(user=self.user)
        url = reverse('resetpass', kwargs={'token': token.token})
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)

    def test_valid_registration_post_token_works(self):
        token = ResetToken.objects.get(user=self.user)
        url = reverse('resetpass', kwargs={'token': token.token})
        data = {
            'password1': "mynewpassword",
            'password2': "mynewpassword",
        }
        response = self.client.post(url, data)
        self.assertEqual(response.status_code, 302) # will redirect to home
        user = User.objects.get(email=self.email)
        self.assertTrue(user.is_registered)

        # login
        self.client.logout()
        self.assertTrue(self.client.login(username=self.email, password="mynewpassword"))

class InvalidRegistrationTests(TestCase):
    def setUp(self):
        self.email = "testemail@epita.fr"
        self.user = User.objects.create_user(email=self.email, password="1234", is_registered=False)
        self.url = reverse('genreset')
        self.data = {
            'email': self.email
        }

    def test_invalid_registration_no_tokens(self):
        tokens = ResetToken.objects.filter(user__email=self.email)
        self.assertEqual(0, tokens.count())

    def test_invalid_registration_wrong_token(self):
        self.client.post(self.url, self.data)
        token = ResetToken.objects.get(user=self.user)
        url = reverse('resetpass', kwargs={'token': "faketoken"})
        response = self.client.get(url)
        self.assertEqual(response.status_code, 400)

    def test_invalid_registration_expired_token(self):
        self.client.post(self.url, self.data)
        expiration = timezone.now() + timezone.timedelta(days=-2)
        ResetToken.objects.filter(user=self.user).update(expiration=expiration)
        token = ResetToken.objects.get(user=self.user)
        url = reverse('resetpass', kwargs={'token': token.token})
        response = self.client.get(url)
        self.assertEqual(response.status_code, 403)

