#!/bin/sh

python source/manage.py makemigrations accounts
python source/manage.py makemigrations dashboard
python source/manage.py makemigrations websites
python source/manage.py migrate accounts
python source/manage.py migrate dashboard
python source/manage.py migrate websites

python source/manage.py runserver 0.0.0.0:8000


exec "$@"
