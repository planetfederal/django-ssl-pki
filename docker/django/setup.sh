#!/usr/bin/env bash

apt-get -y update
# apt-get -y upgrade


### django
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  python-dev \
  python-virtualenv \
  python-setuptools \
  vim

pip2 install -r /code/requirements.txt


### cleanup
apt-get -q clean
apt-get -q purge
rm -rf /var/lib/apt/lists/*
