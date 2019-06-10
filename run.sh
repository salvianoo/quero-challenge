#!/bin/bash

#mix deps.get
HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get
mix local.rebar --force

mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs

MIX_ENV=test mix test
mix phx.server
