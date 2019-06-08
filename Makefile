default:
	docker-compose up --build
	# docker-compose build && docker-compose up
drop:
	docker-compose run --rm -e "MIX_ENV=dev" phoenix mix ecto.drop
test:
	docker-compose run --rm -e "MIX_ENV=test" phoenix mix test
