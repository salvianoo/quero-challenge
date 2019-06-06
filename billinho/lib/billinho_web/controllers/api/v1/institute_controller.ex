defmodule BillinhoWeb.Api.V1.InstituteController do
  use BillinhoWeb, :controller

  alias Billinho.Institutes
  alias Billinho.Institutes.Institute

  action_fallback BillinhoWeb.FallbackController

  def index(conn, _params) do
    institutes = Institutes.list_institutes()
    render(conn, "index.json", institutes: institutes)
  end

  def create(conn, %{"institute" => institute_params}) do
    with {:ok, %Institute{} = institute} <- Institutes.create_institute(institute_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v1_institute_path(conn, :show, institute))
      |> render("show.json", institute: institute)
    end
  end

  def show(conn, %{"id" => id}) do
    institute = Institutes.get_institute!(id)
    render(conn, "show.json", institute: institute)
  end

  def update(conn, %{"id" => id, "institute" => institute_params}) do
    institute = Institutes.get_institute!(id)

    with {:ok, %Institute{} = institute} <- Institutes.update_institute(institute, institute_params) do
      render(conn, "show.json", institute: institute)
    end
  end

  def delete(conn, %{"id" => id}) do
    institute = Institutes.get_institute!(id)

    with {:ok, %Institute{}} <- Institutes.delete_institute(institute) do
      send_resp(conn, :no_content, "")
    end
  end
end
