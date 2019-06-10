defmodule BillinhoWeb.Api.V1.InvoiceView do
  use BillinhoWeb, :view
  alias BillinhoWeb.Api.V1.InvoiceView

  def render("index.json", %{invoices: invoices}) do
    %{data: render_many(invoices, InvoiceView, "invoice.json")}
  end

  def render("show.json", %{invoice: invoice}) do
    %{data: render_one(invoice, InvoiceView, "invoice.json")}
  end

  def render("invoice.json", %{invoice: invoice}) do
    %{
      id: invoice.id,
      price: invoice.price,
      due_date: invoice.due_date,
      status: invoice.status,
      enrollment_id: invoice.enrollment_id
    }
  end
end
