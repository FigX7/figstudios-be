#!/bin/sh

# change to application root
cd /code

# start gunicorn
pipenv run gunicorn wsgi --bind 0.0.0.0:8000 --timeout 120
