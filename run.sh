#!/bin/bash

# docker-compose run --rm phoenix bash run.sh
# sudo chown -R salviano:salviano billinho

# mix ecto.migrate
# exit

# exit

# mix phx.gen.schema Institute institutes cnpj:string:unique name:string:unique type
# mix phx.gen.schema Student students birth_date:date cpf:string:unique gender:string name:string:unique payment_method telephone:decimal
# mix phx.gen.schema Enrollment enrollments course_name due_date:integer total_invoices:integer total_price:float  institute_id:references:institutes student_id:references:students
# mix phx.gen.schema Invoice invoices due_date:date price:float status:string enrollment_id:references:enrollments
# exit

mix deps.get
mix local.rebar --force

mix ecto.create
mix ecto.migrate
# mix run priv/repo/seeds.exs

mix phx.server


#docker-compose run --rm -e "MIX_ENV=test" phoenix mix test
