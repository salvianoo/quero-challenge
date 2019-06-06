defmodule BillinhoWeb.Api.V1.EnrollmentController do
  use BillinhoWeb, :controller

  alias Billinho.Enrollments
  alias Billinho.Enrollments.Enrollment

  action_fallback BillinhoWeb.FallbackController

  def index(conn, _params) do
    enrollments = Enrollments.list_enrollments()
    render(conn, "index.json", enrollments: enrollments)
  end

  def create(conn, %{"enrollment" => enrollment_params}) do
    with {:ok, %Enrollment{} = enrollment} <- Enrollments.create_enrollment(enrollment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v1_enrollment_path(conn, :show, enrollment))
      |> render("show.json", enrollment: enrollment)
    end
  end

  def show(conn, %{"id" => id}) do
    enrollment = Enrollments.get_enrollment!(id)
    render(conn, "show.json", enrollment: enrollment)
  end

  def update(conn, %{"id" => id, "enrollment" => enrollment_params}) do
    enrollment = Enrollments.get_enrollment!(id)

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
