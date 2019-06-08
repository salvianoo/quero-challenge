# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Billinho.Repo.insert!(%Billinho.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# alias Billinho.Students.Student
# alias Billinho.Institutes.Institute
# alias Billinho.Enrollments.Enrollment
# alias Billinho.Invoices.Invoice

alias Billinho.Students
alias Billinho.Institutes
# alias Billinho.Enrollments
# alias Billinho.Invoices

# alias Billinho.Repo

%{
  birth_date: ~D[1988-03-11],
  cpf: "32859656065",
  gender: "F",
  name: "Marta Rocha Felipe",
  payment_method: "Boleto",
  telephone: 64999435794
}
|>
Students.create_student

%{
  name: "Universidade Federal de Uberlândia",
  cnpj: "72.346.635/0001-56",
  type: "Universidade"
}
|>
Institutes.create_institute

# student = %Student{
#   birth_date: ~D[1988-03-11],
#   cpf: "02741316171",
#   gender: "M",
#   name: "Salviano Ludgerio",
#   payment_method: "Boleto",
#   telephone: 64999435794
# }
# |>
# Repo.insert!

# institute = %Institute{
#   name: "Universidade Federal de Uberlândia",
#   cnpj: "72.346.635/0001-56",
#   type: "Universidade"
# }
# |>
# Repo.insert!

#%Enrollment{}

# Como criar uma matricula?
# Find student by id
# Find institute by id
