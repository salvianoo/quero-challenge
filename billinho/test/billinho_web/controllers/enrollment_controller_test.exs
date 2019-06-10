defmodule BillinhoWeb.EnrollmentControllerTest do
  use BillinhoWeb.ConnCase

  alias Billinho.Enrollments.Enrollment
  alias Billinho.Enrollments

  alias Billinho.Students
  alias Billinho.Institutes

  @create_attrs %{
    "course_name" => "AWS for Ruby Developers",
    "due_date" => 16,
    "total_invoices" => 4,
    "total_price" => 220.5
  }
  @update_attrs %{
    "course_name" => "AWS for Elixir Developers",
    "due_date" => 16,
    "total_invoices" => 4,
    "total_price" => 220.5
  }
  @invalid_attrs %{"course_name" => nil, "due_date" => nil, "total_invoices" => nil, "total_price" => nil}

  def fixture(:enrollment) do
    {:ok, student}   = Students.create_student(student_params())
    {:ok, institute} = Institutes.create_institute(institute_params())

    {:ok, enrollment} = Enrollments.create_enrollment(@create_attrs, student, institute)

    enrollment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all enrollments", %{conn: conn} do
      conn = get(conn, Routes.api_v1_enrollment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create enrollment" do
    test "renders enrollment when data is valid", %{conn: conn} do
      {:ok, %{:id => student_id} = _student}     = Students.create_student(student_params())
      {:ok, %{:id => institute_id} = _institute} = Institutes.create_institute(institute_params())

      enrollment_params = Map.merge(@create_attrs, %{"student_id" => student_id, "institute_id" => institute_id})

      conn = post(conn, Routes.api_v1_enrollment_path(conn, :create), enrollment: enrollment_params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_v1_enrollment_path(conn, :show, id))

      assert %{
               "id" => id,
               "course_name" => "AWS for Ruby Developers",
               "due_date" => 16,
               "total_invoices" => 4,
               "total_price" => 220.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {:ok, %{:id => student_id} = _student}     = Students.create_student(student_params())
      {:ok, %{:id => institute_id} = _institute} = Institutes.create_institute(institute_params())

      enrollment_params = Map.merge(@invalid_attrs, %{"student_id" => student_id, "institute_id" => institute_id})

      conn = post(conn, Routes.api_v1_enrollment_path(conn, :create), enrollment: enrollment_params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update enrollment" do
    setup [:create_enrollment]

    test "renders enrollment when data is valid", %{conn: conn, enrollment: %Enrollment{id: id} = enrollment} do
      conn = put(conn, Routes.api_v1_enrollment_path(conn, :update, enrollment), enrollment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_v1_enrollment_path(conn, :show, id))

      assert %{
               "id" => id,
               "course_name" => "AWS for Elixir Developers"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, enrollment: enrollment} do
      conn = put(conn, Routes.api_v1_enrollment_path(conn, :update, enrollment), enrollment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete enrollment" do
    setup [:create_enrollment]

    test "deletes chosen enrollment", %{conn: conn, enrollment: enrollment} do
      conn = delete(conn, Routes.api_v1_enrollment_path(conn, :delete, enrollment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_v1_enrollment_path(conn, :show, enrollment))
      end
    end
  end

  defp create_enrollment(_) do
    enrollment = fixture(:enrollment)
    {:ok, enrollment: enrollment}
  end

  defp student_params() do
    %{
      birth_date: ~D[1988-03-11],
      cpf: "02823471006",
      gender: "F",
      name: "Katrina Owen",
      payment_method: "Cartão",
      telephone: 64999435794
    }
  end

  defp institute_params() do
    %{
      cnpj: "58320879000139",
      name: "Universidade de Porto Real",
      type: "Universidade"
    }
  end
end
