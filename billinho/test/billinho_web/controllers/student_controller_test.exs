defmodule BillinhoWeb.StudentControllerTest do
  use BillinhoWeb.ConnCase

  alias Billinho.Students
  alias Billinho.Students.Student

  @create_attrs %{
    birth_date: ~D[2010-04-17],
    cpf: "some cpf",
    gender: "some gender",
    name: "some name",
    payment_method: "some payment_method",
    telephone: "120.5"
  }
  @update_attrs %{
    birth_date: ~D[2011-05-18],
    cpf: "some updated cpf",
    gender: "some updated gender",
    name: "some updated name",
    payment_method: "some updated payment_method",
    telephone: "456.7"
  }
  @invalid_attrs %{birth_date: nil, cpf: nil, gender: nil, name: nil, payment_method: nil, telephone: nil}

  def fixture(:student) do
    {:ok, student} = Students.create_student(@create_attrs)
    student
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all students", %{conn: conn} do
      conn = get(conn, Routes.student_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create student" do
    test "renders student when data is valid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2010-04-17",
               "cpf" => "some cpf",
               "gender" => "some gender",
               "name" => "some name",
               "payment_method" => "some payment_method",
               "telephone" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.student_path(conn, :create), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update student" do
    setup [:create_student]

    test "renders student when data is valid", %{conn: conn, student: %Student{id: id} = student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.student_path(conn, :show, id))

      assert %{
               "id" => id,
               "birth_date" => "2011-05-18",
               "cpf" => "some updated cpf",
               "gender" => "some updated gender",
               "name" => "some updated name",
               "payment_method" => "some updated payment_method",
               "telephone" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put(conn, Routes.student_path(conn, :update, student), student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, Routes.student_path(conn, :delete, student))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.student_path(conn, :show, student))
      end
    end
  end

  defp create_student(_) do
    student = fixture(:student)
    {:ok, student: student}
  end
end
