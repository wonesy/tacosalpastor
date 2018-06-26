from django import forms
from django.contrib.auth import authenticate
from accounts.models import User as CustomUser

class LoginForm(forms.Form):
    username = forms.EmailField(max_length=255, help_text="Must be your epita-issued email address", required=True,
                             widget=forms.TextInput(attrs={
                                 'placeholder': "yourname@epita.fr",
                             }))
    password = forms.CharField(max_length=255, required=True,
                               widget=forms.PasswordInput(attrs={
                                   'placeholder': 'examplepass',
                               }))


    def clean(self):
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')
        self.user_cache = authenticate(username=username, password=password)
        if not self.user_cache:
            raise forms.ValidationError("Login was invalid, either wrong password or not such email")
        elif not self.user_cache.is_active:
            raise forms.ValidationError("User is no longer active")
        elif not self.user_cache.is_registered:
            raise forms.ValidationError("User is not yet registered")
        return self.cleaned_data

    def get_user(self):
        return self.user_cache


class CustomUserCreationForm(forms.ModelForm):
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Password confirmation', widget=forms.PasswordInput)

    class Meta:
        model = CustomUser
        fields = ('email', 'first_name', 'last_name', 'external_email', 'is_active', 'is_staff', 'is_superuser')

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and (password1 != password2):
            raise forms.ValidationError("Passwords do not match")
        return password2

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user


class CustomUserChangeForm(forms.ModelForm):
    class Meta:
        model = CustomUser
        fields = ['email', 'password', 'first_name', 'last_name', 'external_email', 'is_active', 'is_staff',
                  'is_superuser']

    def save(self, commit=False):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data['password'])
        user.save()
        return user

class ResetPasswordForm(forms.Form):
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Password confirmation', widget=forms.PasswordInput)

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and (password1 != password2):
            raise forms.ValidationError("Passwords do not match")
        return password2