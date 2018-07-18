import os

from setuptools import setup, find_packages

version = __import__('ssl_pki').__version__


def read(*rnames):
    return open(os.path.join(os.path.dirname(__file__), *rnames)).read()


setup(
    name='django-ssl-pki',
    version='1.0.0',
    packages=find_packages(),
    package_dir={'': 'ssl_pki'},
    url='https://github.com/boundlessgeo/django-ssl-pki',
    license='GPLv3+',
    author='Boundless Spatial',
    author_email='contact@boundlessgeo.com',
    description='Adds custom SSL/PKI configurations to Django applications.',
    long_description=(read('README.rst')),
    install_requires=(
        'Django>=1.8',
    ),
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Environment :: Web Environment',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU General Public License v3 or later'
        ' (GPLv3+)',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Security :: Cryptography',
        'Framework :: Django',
        'Framework :: Django :: 1.8',
        'Programming Language :: Python :: 2.7',
    ],
    include_package_data=True,
    zip_safe=False,
)
