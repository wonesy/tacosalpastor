from __future__ import unicode_literals

from django.db import models
from django.core.mail import send_mail
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.utils.translation import ugettext_lazy as _
from django.utils import timezone

class UserManager(BaseUserManager):
    use_in_migrations = True

    def _create_user(self, email, password, **extra_fields):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('The given email must be set')

        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_superuser', False)
        extra_fields.setdefault('is_staff', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_staff', True)

        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(email, password, **extra_fields)

class User(AbstractBaseUser, PermissionsMixin):
    MR = 0
    MS = 1
    MRS = 2

    TITLE_OPTIONS = [
        (MR, "Mr."),
        (MS, "Ms."),
        (MRS, "Mrs.")
    ]
    email = models.EmailField(_('email address'), unique=True)
    title = models.IntegerField(_('title'), default=MR, blank=True, choices=TITLE_OPTIONS)
    first_name = models.CharField(_('first name'), max_length=127, blank=True)
    last_name = models.CharField(_('last name'), max_length=127, blank=True)
    external_email = models.EmailField(_('external email address'), blank=True)
    date_joined = models.DateTimeField(_('date joined'), auto_now_add=True)
    is_active = models.BooleanField(_('active'), default=True)
    is_staff = models.BooleanField(_('Professor'), default=False, blank=True)
    is_registered = models.BooleanField(_('Is registered'), default=False, blank=False)

    objects = UserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')

    def get_full_name(self):
        '''
        Returns the first_name plus the last_name, with a space in between.
        '''
        full_name = "{} {}".format(self.first_name, self.last_name)
        return full_name.strip()

    def get_short_name(self):
        '''
        Returns the short name for the user.
        '''
        return self.first_name

    def email_user(self, subject, message, from_email=None, **kwargs):
        '''
        Sends an email to this User.
        '''
        send_mail(subject, message, from_email, [self.email], **kwargs)

    def __repr__(self):
        return self.get_full_name()

    def __str__(self):
        return self.get_full_name()

class ResetToken(models.Model):
    user = User
    token = models.CharField(max_length=128, blank=False)
    expiration = models.DateTimeField(blank=False)

    def expired(self):
        if timezone.localtime() > self.expiration:
            return True
        return False

    def save(self, domain_override=None, **kwargs):
             # subject_template_name='registration/password_reset_subject.txt',
             # email_template_name='registration/password_reset_email.html',
             # use_https=False,
             # from_email=None, request=None):
        """
        Generates a one-use only link for resetting password and sends to the
        user.
        """
        user = kwargs['user']

        for user in self.users_cache:
            if not domain_override:
                current_site = get_current_site(request)
                site_name = current_site.name
                domain = current_site.domain
            else:
                site_name = domain = domain_override
            c = {
                'email': user.email,
                'domain': domain,
                'site_name': site_name,
                'uid': int_to_base36(user.pk),
                'user': user,
                'token': token_generator.make_token(user),
                'protocol': use_https and 'https' or 'http',
                }
            subject = loader.render_to_string(subject_template_name, c)
            # Email subject *must not* contain newlines
            subject = ''.join(subject.splitlines())
            email = loader.render_to_string(email_template_name, c)
            send_mail(subject, email, from_email, [user.email])