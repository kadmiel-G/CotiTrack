
from django.urls import path
from django.contrib.auth import views as auth_views

from . import views


urlpatterns = [
    path("", views.home, name="home"),
    path("inscription/", views.signup, name="signup"),
    path(
    "connexion/",
    auth_views.LoginView.as_view(
        template_name="accounts/login.html",
        next_page="home",
    ),
    name="login",
),

    path(
        "deconnexion/",
        auth_views.LogoutView.as_view(next_page="home"),
        name="logout",
    ),
]
