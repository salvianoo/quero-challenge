defmodule BillinhoWeb.StudentController do
  use BillinhoWeb, :controller

  def index(conn, _params) do
    json(conn, %{id: 1, name: "Salviano Ludgerio"})
  end
end
