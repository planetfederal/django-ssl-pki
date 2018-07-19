#!/usr/bin/env bash

set -e

### django
find /code -type f -name '*.pyc' -delete
[ -d /tmp/static ] || mkdir /tmp/static

manage='python /code/manage.py'
setup='python /code/setup.py'
# let the db intialize
sleep 5
#$setup build_sphinx
# app integration
plugins=()
if [ "$plugins" ]; then
  export ADDITIONAL_APPS=$(IFS=,; echo "${plugins[*]}")
fi
until ${manage} migrate --noinput; do
  >&2 echo "db is unavailable - sleeping"
  sleep 5
done
${manage} collectstatic --noinput
${manage} makemigrations --dry-run --verbosity 3
pip freeze
echo "Dev is set to ${DEV}"

### runtime
cd /code
cp docker/django/entrypoint.sh /
chmod 0755 /entrypoint.sh
