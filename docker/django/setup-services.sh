#!/usr/bin/env bash

set -e

### runtime
cd /code
cp docker/django/entrypoint.sh /
chmod 0755 /entrypoint.sh
