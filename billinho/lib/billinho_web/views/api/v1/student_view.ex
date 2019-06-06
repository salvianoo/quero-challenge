defmodule BillinhoWeb.Api.V1.StudentView do
  use BillinhoWeb, :view
  alias BillinhoWeb.Api.V1.StudentView

  def render("index.json", %{students: students}) do
    %{data: render_many(students, StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{id: student.id,
      name: student.name,
      cpf: student.cpf,
      birth_date: student.birth_date,
      telephone: student.telephone,
      gender: student.gender,
      payment_method: student.payment_method}
  end
end
