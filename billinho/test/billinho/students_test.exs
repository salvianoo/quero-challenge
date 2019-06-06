defmodule Billinho.StudentsTest do
  use Billinho.DataCase

  alias Billinho.Students

  describe "students" do
    alias Billinho.Students.Student

    @valid_attrs %{birth_date: ~D[2010-04-17], cpf: "some cpf", gender: "some gender", name: "some name", payment_method: "some payment_method", telephone: "120.5"}
    @update_attrs %{birth_date: ~D[2011-05-18], cpf: "some updated cpf", gender: "some updated gender", name: "some updated name", payment_method: "some updated payment_method", telephone: "456.7"}
    @invalid_attrs %{birth_date: nil, cpf: nil, gender: nil, name: nil, payment_method: nil, telephone: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Students.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Students.create_student(@valid_attrs)
      assert student.birth_date == ~D[2010-04-17]
      assert student.cpf == "some cpf"
      assert student.gender == "some gender"
      assert student.name == "some name"
      assert student.payment_method == "some payment_method"
      assert student.telephone == Decimal.new("120.5")
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Students.update_student(student, @update_attrs)
      assert student.birth_date == ~D[2011-05-18]
      assert student.cpf == "some updated cpf"
      assert student.gender == "some updated gender"
      assert student.name == "some updated name"
      assert student.payment_method == "some updated payment_method"
      assert student.telephone == Decimal.new("456.7")
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
