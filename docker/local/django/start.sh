#!/bin/sh

# install dependencies
cd /code


pipenv install --dev

# wait for postgres container to start
# while ! nc -z figstudios-postgres-local 5432; do
#     echo "postgres is unavailable. waiting ..." && sleep 20
# done
# echo "postgres is up" && sleep 10

# change to application root
cd /code/application

# run migrations
pipenv run python manage.py makemigrations
pipenv run python manage.py migrate
# pipenv run python manage.py collectstatic --noinput
# pipenv run python manage.py loaddata fixtures/*


# start dev server
pipenv run python manage.py runserver 0.0.0.0:8000
