#!/bin/bash
# Exit on any error
set -o errexit

# Run migrations
python manage.py migrate

# Start the server
gunicorn a_core.wsgi:application --bind 0.0.0.0:$PORT
