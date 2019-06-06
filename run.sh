#!/bin/bash

# docker-compose run --rm phoenix bash run.sh
# sudo chown -R salviano:salviano billinho

# cd billinho
# mix ecto.migrate
# exit

# mix run priv/repo/seeds.exs

# mix phx.gen.schema Institute institutes cnpj:string:unique name:string:unique type
# mix phx.gen.schema Student students birth_date:date cpf:string:unique gender:string name:string:unique payment_method telephone:decimal
# mix phx.gen.schema Enrollment enrollments course_name due_date:integer total_invoices:integer total_price:float  institute_id:references:institutes student_id:references:students
# mix phx.gen.schema Invoice invoices due_date:date price:float status:string enrollment_id:references:enrollments
# exit

cd billinho
mix deps.get
mix local.rebar --force

mix ecto.create
mix ecto.migrate

mix phx.server
