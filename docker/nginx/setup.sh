#!/usr/bin/env bash

apt-get -y update
# apt-get -y upgrade

### base
#DEBIAN_FRONTEND=noninteractive apt-get install -y \
#  supervisor (use pip)


### nginx
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  ca-certificates \
  openssl \
  curl \
  nginx-light \
  vim


### cleanup
apt-get -q clean
apt-get -q purge
rm -rf /var/lib/apt/lists/*
