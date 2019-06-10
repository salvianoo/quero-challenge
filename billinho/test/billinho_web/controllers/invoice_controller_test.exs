defmodule BillinhoWeb.InvoiceControllerTest do
  use BillinhoWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all invoices", %{conn: conn} do
      conn = get(conn, Routes.api_v1_invoice_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
