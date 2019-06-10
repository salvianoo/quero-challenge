defmodule BillinhoWeb.Api.V1.EnrollmentController do
  use BillinhoWeb, :controller

  alias Billinho.Enrollments
  alias Billinho.Enrollments.Enrollment
  alias Billinho.Students
  alias Billinho.Institutes

  alias Billinho.Repo

  action_fallback BillinhoWeb.FallbackController

  def index(conn, _params) do
    enrollments =
      Enrollments.list_enrollments()
      |> Repo.preload(:invoices)

    render(conn, "index.json", enrollments: enrollments)
  end

  def create(conn, %{"enrollment" => %{"student_id" => student_id, "institute_id" => institute_id} = enrollment_params}) do
    student_task   = Task.async(fn -> Students.get_student!(student_id) end)
    institute_task = Task.async(fn -> Institutes.get_institute!(institute_id) end)

    student   = Task.await(student_task)
    institute = Task.await(institute_task)

    with {:ok, %Enrollment{} = enrollment} <- Enrollments.create_enrollment(enrollment_params, student, institute) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v1_enrollment_path(conn, :show, enrollment))
      |> render("show.json", enrollment: enrollment)
    end
  end

  def show(conn, %{"id" => id}) do
    enrollment =
      Enrollments.get_enrollment!(id)
      |> Repo.preload(:invoices)

    render(conn, "show.json", enrollment: enrollment)
  end

  def update(conn, %{"id" => id, "enrollment" => enrollment_params}) do
    enrollment =
      Enrollments.get_enrollment!(id)
      |> Repo.preload(:invoices)

    with {:ok, %Enrollment{} = enrollment} <- Enrollments.update_enrollment(enrollment, enrollment_params) do
      render(conn, "show.json", enrollment: enrollment)
    end
  end

  def delete(conn, %{"id" => id}) do
    enrollment = Enrollments.get_enrollment!(id)

    with {:ok, %Enrollment{}} <- Enrollments.delete_enrollment(enrollment) do
      send_resp(conn, :no_content, "")
    end
  end
end
