#!/bin/bash

set -e


pip show pip 2>&1 | grep -q 'should consider upgrading' \
  && pip install --upgrade pip || true

pip show pytest > /dev/null || pip install pytest


# clean up previous test run's db
export DOCKER_DJANGO_TEST_DB=/tmp/db-test.sqlite3
[ -e ${DOCKER_DJANGO_TEST_DB} ] && rm -f ${DOCKER_DJANGO_TEST_DB}

pushd /code > /dev/null
  until python manage.py migrate --noinput; do
    >&2 echo "db is unavailable - sleeping"
    sleep 5
  done
  # override some settings, like default DEBUG logging
  export DJANGO_SETTINGS_MODULE='ssl_pki_project.settings'
  pytest --disable-warnings \
    --color=auto \
    --exitfirst \
    --showlocals \
    -k test \
    ssl_pki/tests/test_ssl_pki.py
#  python manage.py test ssl_pki -v 3 --failfast
popd > /dev/null
