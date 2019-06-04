#!/bin/bash

#cd billinho && mix phx.routes
#exit

cd billinho
mix deps.get
#mix local.rebar --force

mix ecto.create
mix ecto.migrate

mix phx.server
