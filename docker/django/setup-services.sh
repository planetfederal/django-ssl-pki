#!/usr/bin/env bash

set -e


### django
pip2 install -r /code/requirements.txt


### runtime
cd /code
cp docker/django/entrypoint.sh /
chmod 0755 /entrypoint.sh
