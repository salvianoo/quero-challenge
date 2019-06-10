defmodule BillinhoWeb.Api.V1.InvoiceController do
  use BillinhoWeb, :controller

  alias Billinho.Invoices

  action_fallback BillinhoWeb.FallbackController

  def index(conn, _params) do
    invoices = Invoices.list_invoices()
    render(conn, "index.json", invoices: invoices)
  end

  def show(conn, %{"id" => id}) do
    invoice = Invoices.get_invoice!(id)
    render(conn, "show.json", invoice: invoice)
  end
end
