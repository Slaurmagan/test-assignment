db-create:
	docker-compose run --rm app rails db:create

db-reset:
	docker-compose run --rm app rails db:reset

db-migrate:
	docker-compose run --rm app rails db:migrate

db-rollback:
	docker-compose run --rm app rails db:rollback

db-remigrate: db-rollback db-migrate

db-seed:
	docker-compose run --rm app rails db:seed

db-drop:
	docker-compose run --rm app rails db:drop
