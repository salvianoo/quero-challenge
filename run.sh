#!/bin/bash

mix deps.get
mix local.rebar --force

mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs

MIX_ENV=test mix test
mix phx.server
