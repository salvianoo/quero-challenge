FROM elixir

RUN apt-get update && apt-get install -y postgresql-client

ADD . /app

RUN mix local.hex --force
RUN mix archive.install hex phx_new --force

WORKDIR /app/billinho
EXPOSE 4000

CMD ["../run.sh"]
