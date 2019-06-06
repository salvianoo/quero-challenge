defmodule BillinhoWeb.Api.V1.EnrollmentView do
  use BillinhoWeb, :view
  alias BillinhoWeb.EnrollmentView

  def render("index.json", %{enrollments: enrollments}) do
    %{data: render_many(enrollments, EnrollmentView, "enrollment.json")}
  end

  def render("show.json", %{enrollment: enrollment}) do
    %{data: render_one(enrollment, EnrollmentView, "enrollment.json")}
  end

  def render("enrollment.json", %{enrollment: enrollment}) do
    %{id: enrollment.id,
      total_price: enrollment.total_price,
      total_invoices: enrollment.total_invoices,
      due_date: enrollment.due_date,
      course_name: enrollment.course_name}
  end
end
