.PHONY: build up down restart logs shell update destroy uber-update

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f

shell:
	docker-compose exec -u user private-browser /bin/bash

update:
	docker-compose down
	docker-compose pull
	docker-compose build --no-cache
	docker-compose up -d

destroy:
	docker-compose down -v --rmi all

uber-update:
	@echo "Performing uber update..."
	docker-compose down -v
	docker system prune -af
	docker volume prune -f
	docker-compose pull
	docker-compose build --no-cache --pull
	docker-compose up -d
	@echo "Uber update complete!"
