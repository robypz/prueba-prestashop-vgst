.PHONY: init up down restart logs sh-app sh-db clean install composer assets front-core front-classic admin-default admin-new-theme admin front cs-fixer phpstan scss-fixer es-linter

## --- Docker Automation ---

init:
	@if [ ! -f .env ]; then cp .env.example .env && echo "Created .env from .env.example"; fi
	docker compose up -d --build

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

sh-app:
	docker compose exec prestashop bash

sh-db:
	docker compose exec db bash

clean:
	docker compose down -v
	rm -f app/config/parameters.php app/config/parameters.yml config/settings.inc.php
	rm -rf var/cache/* var/logs/*
	@echo "Cleaned shop state and reset database volume. Ready for fresh install wizard!"

## --- PrestaShop Development & Assets ---

install: composer assets

composer:
	composer install
	./bin/console cache:clear --no-warmup

assets:
	./tools/assets/build.sh

front-core:
	./tools/assets/build.sh front-core

front-classic:
	./tools/assets/build.sh front-classic

admin-default:
	./tools/assets/build.sh admin-default

admin-new-theme:
	./tools/assets/build.sh admin-new-theme

admin: admin-default admin-new-theme

front: front-core front-classic

cs-fixer:
	./vendor/bin/php-cs-fixer fix

phpstan:
	./vendor/bin/phpstan analyse -c phpstan.neon.dist

scss-fixer:
	cd admin-dev/themes/new-theme && npm run scss-fix
	cd admin-dev/themes/default && npm run scss-fix
	cd themes/classic/_dev && npm run scss-fix

es-linter:
	cd admin-dev/themes/new-theme && npm run lint-fix
	cd admin-dev/themes/default && npm run lint-fix
	cd themes/classic/_dev && npm run lint-fix
	cd themes && npm run lint-fix
