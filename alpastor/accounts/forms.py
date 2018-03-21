from django import forms
from django.contrib.auth import authenticate
from django.contrib.auth.forms import AuthenticationForm

class LoginForm(forms.Form):
    username = forms.EmailField(max_length=255, help_text="Must be your epita-issued email address", required=True,
                             widget=forms.TextInput(attrs={
                                 'onFocus': "field_focus(this, 'yourname@epita.fr');",
                                 'onblur': "field_blur(this, 'yourname@epita.fr');",
                                 'value': "yourname@epita.fr",
                             }))
    password = forms.CharField(max_length=255, required=True,
                               widget=forms.PasswordInput(attrs={
                                   'onFocus': "field_focus(this, 'examplepass');",
                                   'onblur': "field_blur(this, 'examplepass');",
                                   'value': "examplepass",
                               }))


    def clean(self):
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')
        self.user_cache = authenticate(username=username, password=password)
        if not self.user_cache:
            raise forms.ValidationError("Login was invalid")
        elif not self.user_cache.is_active:
            raise forms.ValidationError("User is no longer active")
        return self.cleaned_data

    def get_user(self):
        return self.user_cache

    # def login(self, request):
    #     email = self.cleaned_data.get('email')
    #     password = self.cleaned_data.get('password')
    #     user = authenticate(username=username, password=password)
    #     return user