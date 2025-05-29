#!/bin/bash
set -o errexit

# Wait for database to be ready (important for Render's health checks)
while ! python manage.py check --database default; do
  echo "Waiting for database..."
  sleep 2
done

# Apply migrations
python manage.py migrate

# Create superuser if not exists
python manage.py create_admin --noinput

# Start the main server
gunicorn a_core.wsgi:application --bind 0.0.0.0:$PORT
