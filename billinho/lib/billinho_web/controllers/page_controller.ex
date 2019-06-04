defmodule BillinhoWeb.PageController do
  use BillinhoWeb, :controller

  def index(conn, _params) do
    json(conn, %{id: 1, name: "Salviano"})
  end
end
