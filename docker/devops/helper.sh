#!/bin/bash

# Code style checks
function lint {
    echo "-------> ssl_pki pycodestyle"
    pycodestyle . --ignore=E722,E731
    echo "-------> ssl_pki flake8"
    flake8 --ignore=F405,E722,E731 .
}

function makemigrations-check {
    if [[ ! $(python manage.py makemigrations --dry-run) == "No changes detected" ]]; then
      python manage.py makemigrations --dry-run --verbosity 3
      echo "Please commit your migrations"
      exit 1
    else
      echo "No migrations detected"
    fi
}
