#!/bin/bash

### Setup django
find /code -type f -name '*.pyc' -delete
[ -d /tmp/static ] || mkdir /tmp/static

manage='python /code/manage.py'
setup='python /code/setup.py'
# let the db intialize
sleep 5
#$setup build_sphinx

until ${manage} migrate --noinput; do
  >&2 echo "db is unavailable - sleeping"
  sleep 5
done
${manage} collectstatic --noinput
${manage} makemigrations --dry-run --verbosity 3

pip freeze
echo "Dev is set to ${DEV}"

# Run django
if [[ $DEV == True ]]; then
  python manage.py runserver 0.0.0.0:8808
else
  bash -c "DEBUG=False waitress-serve --port=8808 ssl_pki_project.wsgi:application"
fi
