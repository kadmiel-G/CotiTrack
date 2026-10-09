
from django import forms
from django.contrib.auth.forms import UserCreationForm

from .models import User


class SignUpForm(UserCreationForm):
    email = forms.EmailField(
        required=True,
        label="Adresse e-mail",
    )

    class Meta:
        model = User
        fields = (
            "username",
            "email",
            "password1",
            "password2",
        )

    def save(self, commit=True):
        user = super().save(commit=False)
        user.role = User.Role.MEMBER

        if commit:
            user.save()

        return user
    
