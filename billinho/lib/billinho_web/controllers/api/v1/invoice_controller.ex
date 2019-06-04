defmodule BillinhoWeb.Api.V1.InvoiceController do
  use BillinhoWeb, :controller

  def index(conn, _params) do
    json(conn, %{id: 1, name: "Salviano Ludgerio F Gomes"})
  end
end
