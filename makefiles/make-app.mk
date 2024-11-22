rspec:
	docker-compose run --rm app rspec $(ARGS)

rails:
	docker-compose run --rm app rails $(ARGS)

bundle:
	docker-compose run --rm app bundle $(ARGS)

bundle-install:
	docker-compose run --rm app bundle install

be:
	docker-compose run --rm app bundle exec $(ARGS)

bi:
	docker-compose run --rm app bundle install $(ARGS)

sh:
	docker-compose run --rm app sh

bash:
	docker-compose run --rm app bash

routes:
	docker-compose run --rm app rails routes | grep "$(ARGS)"

rc:
	docker-compose run --rm app rails console

migration:
	docker-compose run --rm app rails generate migration $(ARGS)

g:
	docker-compose run --rm app rails generate $(ARGS)

rubocop:
	docker-compose run --rm app bundle exec rubocop $(ARGS)

rubocop-correct:
	docker-compose run --rm app bundle exec rubocop --auto-correct $(ARGS)

telegram-pooling:
	docker-compose run --rm app rails runner lib/telegram_bot/pooling.rb

swaggerize:
	docker-compose run --rm app rake rswag:specs:swaggerize

set_telegram_webhooks:
	docker-compose run --rm app rails runner "Bot.all.each(&:set_telegram_webhook)"
