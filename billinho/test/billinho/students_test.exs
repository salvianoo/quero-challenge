defmodule Billinho.StudentsTest do
  use Billinho.DataCase

  alias Billinho.Students

  describe "students" do
    alias Billinho.Students.Student

    @valid_attrs %{birth_date: ~D[2010-04-17], cpf: "32859656065", gender: "M", name: "Luke Skywalker", payment_method: "Boleto", telephone: 64999435794}
    @update_attrs %{birth_date: ~D[2011-05-18], cpf: "88606688088", gender: "F", name: "Leia Organa", payment_method: "Cartão", telephone: 34999435794}
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
      assert student.cpf == "32859656065"
      assert student.gender == "M"
      assert student.name == "Luke Skywalker"
      assert student.payment_method == "Boleto"
      assert student.telephone == Decimal.new("64999435794")
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Students.update_student(student, @update_attrs)
      assert student.birth_date == ~D[2011-05-18]
      assert student.cpf == "88606688088"
      assert student.gender == "F"
      assert student.name == "Leia Organa"
      assert student.payment_method == "Cartão"
      assert student.telephone == Decimal.new("34999435794")
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
