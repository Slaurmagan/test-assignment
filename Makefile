ARGS = $(filter-out $@,$(MAKECMDGOALS))

%:
	@:

include ./makefiles/*.mk

setup: build db-create db-migrate yarn-install build-css bundle-install

build:
	DOCKER_BUILDKIT=1 docker build . --ssh default -t test-assignment -f Dockerfile

up:
	docker-compose up --detach --remove-orphans

down:
	docker-compose down --remove-orphans

down-all:
	docker-compose down --volumes --remove-orphans --rmi all

restart:
	docker-compose restart $(ARGS)
