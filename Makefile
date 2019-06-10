default:
	docker-compose up --build
drop:
	docker-compose run --rm -e "MIX_ENV=dev" phoenix mix ecto.drop
	docker-compose run --rm -e "MIX_ENV=test" phoenix mix ecto.drop
test:
	docker-compose run --rm -e "MIX_ENV=test" phoenix mix test
routes:
	docker-compose run --rm phoenix mix phx.routes
