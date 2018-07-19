FROM python:2-stretch
MAINTAINER Boundless development team

WORKDIR /code

COPY . .
RUN bash /code/docker/django/setup.sh
RUN bash /code/docker/django/setup-services.sh

EXPOSE 8808

# Launch everything in background
CMD /entrypoint.sh
