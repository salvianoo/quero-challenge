defmodule Billinho.EnrollmentsTest do
  use Billinho.DataCase

  alias Billinho.Enrollments
  alias Billinho.Students
  alias Billinho.Institutes

  describe "enrollments" do
    alias Billinho.Enrollments.Enrollment

    @student_attrs %{birth_date: ~D[2010-04-17], cpf: "32859656065", gender: "M", name: "Luke Skywalker", payment_method: "Boleto", telephone: 64999435794}
    @institute_attrs %{cnpj: "94988448000109", name: "Universidade de Winterfell", type: "Universidade"}

    @valid_attrs %{"course_name" => "Elixir for Ruby Developers", "due_date" => 10, "total_invoices" => 5, "total_price" => 2_000.0}
    @update_attrs %{"course_name" => "Phoenix for Rails Developers", "due_date" => 10, "total_invoices" => 4, "total_price" => 499.9}
    @invalid_attrs %{"course_name" => nil, "due_date" => nil, "total_invoices" => nil, "total_price" => nil}

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
        |> Enum.into(@valid_attrs)
        |> Enrollments.create_enrollment(student, institute)

      enrollment
    end

    test "list_enrollments/0 returns all enrollments" do
      enrollment = enrollment_fixture()
      enrollments = Enrollments.list_enrollments()

      [ first | _tail ] = enrollments

      assert [Map.delete(first, :invoices)] == [Map.delete(enrollment, :invoices)]
    end

    test "get_enrollment!/1 returns the enrollment with given id" do
      enrollment = enrollment_fixture()
      found_enrollment = Enrollments.get_enrollment!(enrollment.id)

      assert Map.delete(found_enrollment, :invoices) == Map.delete(enrollment, :invoices)
    end

    test "create_enrollment/3 with valid data creates a enrollment" do
      student = student_fixture()
      institute = institute_fixture()

      assert {:ok, %Enrollment{} = enrollment} = Enrollments.create_enrollment(@valid_attrs, student, institute)
      assert enrollment.course_name == "Elixir for Ruby Developers"
      assert enrollment.due_date == 10
      assert enrollment.total_invoices == 5
      assert enrollment.total_price == 2_000.0

      assert enrollment.student == student
      assert enrollment.institute == institute
    end

    test "total of invoices created for the associated enrollment" do
      enrollment = enrollment_fixture()

      assert length(enrollment.invoices) == Map.get(@valid_attrs, "total_invoices")
    end

    test "price of invoices" do
      enrollment = enrollment_fixture()
      enrollment_price = Map.get(@valid_attrs, "total_price") / Map.get(@valid_attrs, "total_invoices")

      [invoice | _tail ] = enrollment.invoices

      assert invoice.price == enrollment_price
    end

    test "create_enrollment/3 with invalid data returns error changeset" do
      student = student_fixture()
      institute = institute_fixture()

      assert {:error, %Ecto.Changeset{}} = Enrollments.create_enrollment(@invalid_attrs, student, institute)
    end

    test "update_enrollment/2 with valid data updates the enrollment" do
      enrollment = enrollment_fixture()

      assert {:ok, %Enrollment{} = enrollment} = Enrollments.update_enrollment(enrollment, @update_attrs)
      assert enrollment.course_name == "Phoenix for Rails Developers"
      assert enrollment.due_date == 10
      assert enrollment.total_invoices == 4
      assert enrollment.total_price == 499.9
    end

    test "update_enrollment/2 with invalid data returns error changeset" do
      enrollment = enrollment_fixture()
      assert {:error, %Ecto.Changeset{}} = Enrollments.update_enrollment(enrollment, @invalid_attrs)

      found_enrollment = Enrollments.get_enrollment!(enrollment.id)
      assert Map.delete(enrollment, :invoices) == Map.delete(found_enrollment, :invoices)
    end

    test "delete_enrollment/1 deletes the enrollment" do
      enrollment = enrollment_fixture()
      assert {:ok, %Enrollment{}} = Enrollments.delete_enrollment(enrollment)
      assert_raise Ecto.NoResultsError, fn -> Enrollments.get_enrollment!(enrollment.id) end
    end

    test "change_enrollment/1 returns a enrollment changeset" do
      enrollment = enrollment_fixture()
      assert %Ecto.Changeset{} = Enrollments.change_enrollment(enrollment)
    end
  end
end
