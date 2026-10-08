
from .models import User


def is_member(user):
    return user.is_authenticated and user.role == User.Role.MEMBER


def is_collector(user):
    return user.is_authenticated and user.role == User.Role.COLLECTOR


def is_admin(user):
    return user.is_authenticated and (
        user.role == User.Role.ADMIN or user.is_superuser
    )


def is_auditor(user):
    return user.is_authenticated and user.role == User.Role.AUDITOR