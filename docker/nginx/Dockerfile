FROM python:2-stretch
MAINTAINER Boundless development team

WORKDIR /code

COPY . .
RUN bash /code/setup.sh
RUN bash /code/setup-services.sh

EXPOSE 8880 8881 8444 8445

# Launch everything in background
CMD /entrypoint.sh
