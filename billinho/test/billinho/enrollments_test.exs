defmodule Billinho.EnrollmentsTest do
  use Billinho.DataCase

  alias Billinho.Enrollments

  describe "enrollments" do
    alias Billinho.Enrollments.Enrollment

    @valid_attrs %{course_name: "some course_name", due_date: 42, total_invoices: 42, total_price: 120.5}
    @update_attrs %{course_name: "some updated course_name", due_date: 43, total_invoices: 43, total_price: 456.7}
    @invalid_attrs %{course_name: nil, due_date: nil, total_invoices: nil, total_price: nil}

    def enrollment_fixture(attrs \\ %{}) do
      {:ok, enrollment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enrollments.create_enrollment()

      enrollment
    end

    test "list_enrollments/0 returns all enrollments" do
      enrollment = enrollment_fixture()
      assert Enrollments.list_enrollments() == [enrollment]
    end

    test "get_enrollment!/1 returns the enrollment with given id" do
      enrollment = enrollment_fixture()
      assert Enrollments.get_enrollment!(enrollment.id) == enrollment
    end

    test "create_enrollment/1 with valid data creates a enrollment" do
      assert {:ok, %Enrollment{} = enrollment} = Enrollments.create_enrollment(@valid_attrs)
      assert enrollment.course_name == "some course_name"
      assert enrollment.due_date == 42
      assert enrollment.total_invoices == 42
      assert enrollment.total_price == 120.5
    end

    test "create_enrollment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Enrollments.create_enrollment(@invalid_attrs)
    end

    test "update_enrollment/2 with valid data updates the enrollment" do
      enrollment = enrollment_fixture()
      assert {:ok, %Enrollment{} = enrollment} = Enrollments.update_enrollment(enrollment, @update_attrs)
      assert enrollment.course_name == "some updated course_name"
      assert enrollment.due_date == 43
      assert enrollment.total_invoices == 43
      assert enrollment.total_price == 456.7
    end

    test "update_enrollment/2 with invalid data returns error changeset" do
      enrollment = enrollment_fixture()
      assert {:error, %Ecto.Changeset{}} = Enrollments.update_enrollment(enrollment, @invalid_attrs)
      assert enrollment == Enrollments.get_enrollment!(enrollment.id)
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
