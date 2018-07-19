SHELL:=bash
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

.PHONY: help html lint start purge stop recreate test maploom

help:
	@echo "  make lint     - run to lint (style check) repo"
	@echo "  make start    - start containers"
	@echo "  make stop     - stop containers"
	@echo "  make purge    - stop containers and prune volumes"
	@echo "  make recreate - stop containers, prune volumes and recreate/build containers"
	@echo "  make test     - run unit tests"

lint:
	@docker run --rm -v $(current_dir):/code \
	                 -w /code quay.io/boundlessgeo/sonar-maven-py3-alpine bash \
	                 -e -c '. docker/devops/helper.sh && lint'

stop:
	@docker-compose down --remove-orphans

start: stop
	@docker-compose up -d --build

purge: stop
	@docker volume prune -f

recreate: purge
	@docker-compose up -d --build --force-recreate

test: migration-check
	@echo "Note: test requires the django container to be running and healthy"
	@docker-compose exec django /code/docker/django/run_tests.sh

migration-check:
	@docker-compose exec -T django /bin/bash \
	                     -c '. docker/devops/helper.sh && makemigrations-check'
