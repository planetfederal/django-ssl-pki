#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJ_DIR=${SCRIPT_DIR}/ssl_pki_project
DEV=True

cd ${SCRIPT_DIR}

. .env

export PYTHONPATH=./:./venv/lib/python2.7/site-packages

### Setup django
find ./ -type f -name '*.pyc' -delete
[ -d /tmp/static ] && rm -Rf /tmp/static/* || mkdir /tmp/static

[ -f "${PROJ_DIR}/db.sqlite3" ] && rm -f "${PROJ_DIR}/db.sqlite3"

manage='python manage.py'
setup='python setup.py'
# let the db intialize
sleep 5
#$setup build_sphinx

until ${manage} migrate --noinput; do
  >&2 echo "db is unavailable - sleeping"
  sleep 5
done
${manage} loaddata default_users
${manage} collectstatic --noinput
${manage} makemigrations --dry-run --verbosity 3

pip freeze
echo "Dev is set to ${DEV}"

# Run django test server
python manage.py runserver django-pki.boundless.test:8809
