#!/bin/sh
# install dependencies
cd /code


pipenv install --dev
# change to application root
cd /code/application

# run migrations
pipenv run python manage.py migrate
# pipenv run python manage.py collectstatic --noinput
# pipenv run python manage.py loaddata fixtures/*


# start dev server
pipenv run python manage.py runserver 0.0.0.0:8000
