# defmodule Billinho.InvoicesTest do
#   use Billinho.DataCase

#   alias Billinho.Invoices

#   describe "invoices" do
#     alias Billinho.Invoices.Invoice

#     @valid_attrs %{due_date: ~D[2010-04-17], price: 120.5, status: "some status"}
#     @update_attrs %{due_date: ~D[2011-05-18], price: 456.7, status: "some updated status"}
#     @invalid_attrs %{due_date: nil, price: nil, status: nil}

#     def invoice_fixture(attrs \\ %{}) do
#       {:ok, invoice} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Invoices.create_invoice()

#       invoice
#     end

#     test "list_invoices/0 returns all invoices" do
#       invoice = invoice_fixture()
#       assert Invoices.list_invoices() == [invoice]
#     end

#     test "get_invoice!/1 returns the invoice with given id" do
#       invoice = invoice_fixture()
#       assert Invoices.get_invoice!(invoice.id) == invoice
#     end

#     test "create_invoice/1 with valid data creates a invoice" do
#       assert {:ok, %Invoice{} = invoice} = Invoices.create_invoice(@valid_attrs)
#       assert invoice.due_date == ~D[2010-04-17]
#       assert invoice.price == 120.5
#       assert invoice.status == "some status"
#     end

#     test "create_invoice/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Invoices.create_invoice(@invalid_attrs)
#     end

#     test "update_invoice/2 with valid data updates the invoice" do
#       invoice = invoice_fixture()
#       assert {:ok, %Invoice{} = invoice} = Invoices.update_invoice(invoice, @update_attrs)
#       assert invoice.due_date == ~D[2011-05-18]
#       assert invoice.price == 456.7
#       assert invoice.status == "some updated status"
#     end

#     test "update_invoice/2 with invalid data returns error changeset" do
#       invoice = invoice_fixture()
#       assert {:error, %Ecto.Changeset{}} = Invoices.update_invoice(invoice, @invalid_attrs)
#       assert invoice == Invoices.get_invoice!(invoice.id)
#     end

#     test "delete_invoice/1 deletes the invoice" do
#       invoice = invoice_fixture()
#       assert {:ok, %Invoice{}} = Invoices.delete_invoice(invoice)
#       assert_raise Ecto.NoResultsError, fn -> Invoices.get_invoice!(invoice.id) end
#     end

#     test "change_invoice/1 returns a invoice changeset" do
#       invoice = invoice_fixture()
#       assert %Ecto.Changeset{} = Invoices.change_invoice(invoice)
#     end
#   end
# end
