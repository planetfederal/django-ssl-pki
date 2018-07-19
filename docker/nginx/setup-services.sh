#!/usr/bin/env bash

set -e


### nginx
cd /code

nginx_etc=/etc/nginx

# Setup SSL
cp -R ./ssl ${nginx_etc}/
nginx_ssl=${nginx_etc}/ssl
chmod 0644 ${nginx_ssl}/*.crt
chmod 0600 ${nginx_ssl}/*.key

[ -d ${nginx_etc}/incl.d ] || mkdir ${nginx_etc}/incl.d
cp incl.d/ssl_cert ${nginx_etc}/incl.d/ssl_cert

cp -f sites-available/default ${nginx_etc}/sites-available/
cp sites-available/*.conf ${nginx_etc}/sites-available/
ln -fs ../sites-available/django.conf ${nginx_etc}/sites-enabled/django.conf
ln -fs ../sites-available/endpoint.conf ${nginx_etc}/sites-enabled/endpoint.conf

# Forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log

# Still necessary with nginx-light on stretch?
#cd /etc/nginx
#ln -fs /usr/lib/nginx/modules modules

# Use 2048 bit Diffie-Hellman RSA key parameters
# (otherwise Nginx defaults to 1024 bit, lowering the strength of encryption # when using PFS)
# NOTE: this takes a minute or two
# See: https://juliansimioni.com/blog/https-on-nginx-from-zero-to-a-plus-part-2-configuration-ciphersuites-and-performance/
# Note that we need to use a directory that is not overlaid by other docker volumes!
if [ ! -e ${nginx_ssl}/dhparam2048.pem ]; then
  openssl dhparam -outform pem -out ${nginx_ssl}/dhparam2048.pem 2048
  chmod 0600 ${nginx_ssl}/dhparam2048.pem
fi

### runtime
cd /code
cp entrypoint.sh /
chmod 0755 /entrypoint.sh
