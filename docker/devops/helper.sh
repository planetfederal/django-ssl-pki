#!/bin/bash

# Code style checks
function lint {
    echo "-------> ssl_pki flake8"
    flake8 --exclude=.git,.pytest_cache,__pycache__,venv,.venv --ignore=F405,E722,E731 . || true
    echo "-------> ssl_pki yamllint"
    yamllint -d "{extends: relaxed, rules: {line-length: {max: 120}}}" $(find . -name "*.yml" -not -path "*venv/*") || true
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
