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

alias Billinho.Students
alias Billinho.Institutes
alias Billinho.Enrollments

{:ok, student} =
  %{
    birth_date: ~D[1988-03-11],
    cpf: "32859656065",
    gender: "F",
    name: "Sandi Metz",
    payment_method: "Boleto",
    telephone: 64999435794
  }
  |> Students.create_student()

{:ok, institute} =
  %{
    name: "Universidade do Código Bonito",
    cnpj: "81256959000194",
    type: "Universidade"
  }
  |> Institutes.create_institute()

%{
  "course_name" => "Practical Object-Oriented Design Course",
  "due_date" => 21,
  "total_invoices" => 4,
  "total_price" => 1680.0
}
|> Enrollments.create_enrollment(student, institute)
