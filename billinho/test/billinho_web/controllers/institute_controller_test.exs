defmodule BillinhoWeb.InstituteControllerTest do
  use BillinhoWeb.ConnCase

  alias Billinho.Institutes
  alias Billinho.Institutes.Institute

  @create_attrs %{
    cnpj: "some cnpj",
    name: "some name",
    type: "some type"
  }
  @update_attrs %{
    cnpj: "some updated cnpj",
    name: "some updated name",
    type: "some updated type"
  }
  @invalid_attrs %{cnpj: nil, name: nil, type: nil}

  def fixture(:institute) do
    {:ok, institute} = Institutes.create_institute(@create_attrs)
    institute
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all institutes", %{conn: conn} do
      conn = get(conn, Routes.institute_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create institute" do
    test "renders institute when data is valid", %{conn: conn} do
      conn = post(conn, Routes.institute_path(conn, :create), institute: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.institute_path(conn, :show, id))

      assert %{
               "id" => id,
               "cnpj" => "some cnpj",
               "name" => "some name",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.institute_path(conn, :create), institute: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update institute" do
    setup [:create_institute]

    test "renders institute when data is valid", %{conn: conn, institute: %Institute{id: id} = institute} do
      conn = put(conn, Routes.institute_path(conn, :update, institute), institute: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.institute_path(conn, :show, id))

      assert %{
               "id" => id,
               "cnpj" => "some updated cnpj",
               "name" => "some updated name",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, institute: institute} do
      conn = put(conn, Routes.institute_path(conn, :update, institute), institute: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete institute" do
    setup [:create_institute]

    test "deletes chosen institute", %{conn: conn, institute: institute} do
      conn = delete(conn, Routes.institute_path(conn, :delete, institute))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.institute_path(conn, :show, institute))
      end
    end
  end

  defp create_institute(_) do
    institute = fixture(:institute)
    {:ok, institute: institute}
  end
end
