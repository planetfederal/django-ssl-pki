#!/bin/bash

if [[ $DEV == True ]]; then
  python manage.py runserver 0.0.0.0:8808
else
  bash -c "DEBUG=False waitress-serve --port=8808 ssl_pki_project.wsgi:application"
fi
