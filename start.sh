#!/bin/bash
set -o errexit

# Run migrations
python manage.py migrate

# Start the bot in the background
python manage.py runbot &

# Start the main server
gunicorn a_core.wsgi:application --bind 0.0.0.0:$PORT
