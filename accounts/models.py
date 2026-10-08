from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    class Role(models.TextChoices):
        MEMBER = "MEMBER", "Membre"
        COLLECTOR = "COLLECTOR", "Collecteur"
        ADMIN = "ADMIN", "Administrateur"
        AUDITOR = "AUDITOR", "Auditeur"

    role = models.CharField(
        max_length=20,
        choices=Role.choices,
        default=Role.MEMBER,
    )
