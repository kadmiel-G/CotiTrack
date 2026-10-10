
from django.contrib import admin

from .models import Tontine, Participation


@admin.register(Tontine)
class TontineAdmin(admin.ModelAdmin):
    list_display = (
        "name",
        "created_by",
        "contribution_amount",
        "frequency",
        "status",
        "created_at",
    )

    list_filter = (
        "status",
        "frequency",
        "created_at",
    )

    search_fields = (
        "name",
        "description",
        "created_by__username",
    )

    readonly_fields = (
        "created_at",
        "updated_at",
    )


@admin.register(Participation)
class ParticipationAdmin(admin.ModelAdmin):
    list_display = (
        "user",
        "tontine",
        "role",
        "status",
        "joined_at",
    )

    list_filter = (
        "role",
        "status",
    )

    search_fields = (
        "user__username",
        "tontine__name",
    )

    readonly_fields = (
        "joined_at",
    )



