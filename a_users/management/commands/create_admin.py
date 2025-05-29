from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
import os

class Command(BaseCommand):
    help = 'Creates admin user if not exists'

    def add_arguments(self, parser):
        parser.add_argument('--noinput', action='store_true', help='Skip confirmation')

    def handle(self, *args, **options):
        User = get_user_model()
        email = os.getenv('ADMIN_EMAIL')
        password = os.getenv('ADMIN_PASSWORD')

        if not User.objects.filter(email=email).exists():
            User.objects.create_superuser(
                username='admin',
                email=email,
                password=password
            )
            self.stdout.write(self.style.SUCCESS('Admin user created'))
        else:
            self.stdout.write(self.style.WARNING('Admin user already exists'))
