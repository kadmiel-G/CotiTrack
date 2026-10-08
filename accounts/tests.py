
from django.test import TestCase
from django.contrib.auth import get_user_model

from .permissions import is_member, is_collector, is_admin, is_auditor


User = get_user_model()


class RolePermissionTests(TestCase):
    def create_user_with_role(self, role):
        return User.objects.create_user(
            username=f"user_{role.lower()}",
            password="TestPassword123!",
            role=role,
        )

    def test_member_role(self):
        user = self.create_user_with_role(User.Role.MEMBER)
        self.assertTrue(is_member(user))
        self.assertFalse(is_collector(user))
        self.assertFalse(is_admin(user))
        self.assertFalse(is_auditor(user))

    def test_collector_role(self):
        user = self.create_user_with_role(User.Role.COLLECTOR)
        self.assertTrue(is_collector(user))
        self.assertFalse(is_member(user))
        self.assertFalse(is_admin(user))
        self.assertFalse(is_auditor(user))

    def test_admin_role(self):
        user = self.create_user_with_role(User.Role.ADMIN)
        self.assertTrue(is_admin(user))
        self.assertFalse(is_member(user))
        self.assertFalse(is_collector(user))
        self.assertFalse(is_auditor(user))

    def test_auditor_role(self):
        user = self.create_user_with_role(User.Role.AUDITOR)
        self.assertTrue(is_auditor(user))
        self.assertFalse(is_member(user))
        self.assertFalse(is_collector(user))
        self.assertFalse(is_admin(user))

    def test_anonymous_user_has_no_role(self):
        from django.contrib.auth.models import AnonymousUser

        user = AnonymousUser()
        self.assertFalse(is_member(user))
        self.assertFalse(is_collector(user))
        self.assertFalse(is_admin(user))
        self.assertFalse(is_auditor(user))
