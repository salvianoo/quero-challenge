defmodule Billinho.InvoicesTest do
  use Billinho.DataCase

  alias Billinho.Invoices
  alias Billinho.Students
  alias Billinho.Institutes
  alias Billinho.Enrollments

  describe "invoices" do

    @student_attrs %{birth_date: ~D[2010-04-17], cpf: "32859656065", gender: "M", name: "Luke Skywalker", payment_method: "Boleto", telephone: 64999435794}
    @institute_attrs %{cnpj: "94988448000109", name: "Universidade de Winterfell", type: "Universidade"}
    @enrollment_attrs %{"course_name" => "Elixir for Ruby Developers", "due_date" => 10, "total_invoices" => 5, "total_price" => 2_000.0}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@student_attrs)
        |> Students.create_student()

      student
    end

    def institute_fixture(attrs \\ %{}) do
      {:ok, institute} =
        attrs
        |> Enum.into(@institute_attrs)
        |> Institutes.create_institute()

      institute
    end

    def enrollment_fixture(attrs \\ %{}) do
      student = student_fixture()
      institute = institute_fixture()

      {:ok, enrollment} =
        attrs
        |> Enum.into(@enrollment_attrs)
        |> Enrollments.create_enrollment(student, institute)

      enrollment
    end

    test "list_invoices/0 returns all invoices" do
      enrollment = enrollment_fixture()

      assert Invoices.list_invoices() == enrollment.invoices
    end

    test "get_invoice!/1 returns the invoice with given id" do
      enrollment = enrollment_fixture()

      [invoice | _tail] = enrollment.invoices

      assert Invoices.get_invoice!(invoice.id) == invoice
    end
  end
end
