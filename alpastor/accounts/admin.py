from django.contrib import admin
from accounts.models import User
from accounts.forms import CustomUserCreationForm, CustomUserChangeForm
from django.contrib.auth.admin import UserAdmin


class CustomUserAdmin(UserAdmin):
    form = CustomUserChangeForm
    add_form = CustomUserCreationForm

    list_display = ('email', 'password', 'first_name', 'last_name', 'external_email', 'is_staff', 'is_superuser',)
    fieldsets = ((None, {'fields':
                             ('email', 'external_email', 'password', 'last_name', 'first_name', 'is_staff', 'is_superuser')
                         }
                  ),
                 )
    readonly_fields = ('date_joined', 'password')
    ordering = ('email',)
    exclude = ('username',)
    add_fieldsets = (
        (None, {
            'fields': (
                'email', 'password1', 'password2', 'first_name', 'last_name', 'external_email', 'is_staff',
                'is_superuser')}
         ),
    )
    search_fields = ('email',)
    filter_horizontal = ()


admin.site.register(User, CustomUserAdmin)
