yarn-install:
	docker-compose run --rm app yarn install

build-css:
	docker-compose run --rm app yarn build:css
