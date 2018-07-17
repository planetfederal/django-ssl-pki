=================================
Django SSL/PKI
=================================

:Version: 1.0.0
:Source: http://github.com/fireantology/django-logtailer/
--


Adds custom SSL/PKI configurations to Django applications.

Requirements
========

- Django > 1.8
- Python 2.x

See requirements.txt.

Installation
========

- Install the package with pip install django-exchange-pki
- Add django_ssl_pki to the INSTALLED_APPS in your SETTINGS
- Add to urls.py: url(r'^logs/', include('logtailer.urls')),
- Run manage.py migrate for create the required tables
- Run manage.py collectstatic

SETTING OPTIONS AVAILABLE
========

 - VAR - Description
