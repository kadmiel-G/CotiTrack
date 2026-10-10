
from django.conf import settings
from django.db import models


class Tontine(models.Model):
    class Status(models.TextChoices):
        DRAFT = "BROUILLON", "Brouillon"
        ACTIVE = "ACTIVE", "Active"
        SUSPENDED = "SUSPENDUE", "Suspendue"
        COMPLETED = "TERMINEE", "Terminée"
        ARCHIVED = "ARCHIVEE", "Archivée"

    class Frequency(models.TextChoices):
        DAILY = "QUOTIDIENNE", "Quotidienne"
        WEEKLY = "HEBDOMADAIRE", "Hebdomadaire"
        MONTHLY = "MENSUELLE", "Mensuelle"
        CUSTOM = "PERSONNALISEE", "Personnalisée"

    name = models.CharField(max_length=150)

    description = models.TextField(blank=True)

    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name="created_tontines",
    )

    contribution_amount = models.DecimalField(
        max_digits=12,
        decimal_places=2,
        null=True,
        blank=True,
    )

    frequency = models.CharField(
        max_length=20,
        choices=Frequency.choices,
        default=Frequency.MONTHLY,
    )

    status = models.CharField(
        max_length=10,
        choices=Status.choices,
        default=Status.DRAFT,
    )

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Participation(models.Model):
    class Role(models.TextChoices):
        MEMBER = "MEMBRE", "Membre"
        COLLECTOR = "COLLECTEUR", "Collecteur"

    class Status(models.TextChoices):
        INVITED = "INVITE", "Invité"
        ACTIVE = "ACTIF", "Actif"
        LEFT = "PARTI", "Parti"

    tontine = models.ForeignKey(
        Tontine,
        on_delete=models.PROTECT,
        related_name="participations",
    )

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name="participations_tontines",
    )

    role = models.CharField(
        max_length=12,
        choices=Role.choices,
        default=Role.MEMBER,
    )

    status = models.CharField(
        max_length=10,
        choices=Status.choices,
        default=Status.ACTIVE,
    )

    joined_at = models.DateTimeField(
        auto_now_add=True,
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=["tontine", "user"],
                name="unique_user_per_tontine",
            ),
        ]

    def __str__(self):
        return f"{self.user} - {self.tontine} ({self.role})"

