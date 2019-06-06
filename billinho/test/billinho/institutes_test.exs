defmodule Billinho.InstitutesTest do
  use Billinho.DataCase

  alias Billinho.Institutes

  describe "institutes" do
    alias Billinho.Institutes.Institute

    @valid_attrs %{cnpj: "some cnpj", name: "some name", type: "some type"}
    @update_attrs %{cnpj: "some updated cnpj", name: "some updated name", type: "some updated type"}
    @invalid_attrs %{cnpj: nil, name: nil, type: nil}

    def institute_fixture(attrs \\ %{}) do
      {:ok, institute} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Institutes.create_institute()

      institute
    end

    test "list_institutes/0 returns all institutes" do
      institute = institute_fixture()
      assert Institutes.list_institutes() == [institute]
    end

    test "get_institute!/1 returns the institute with given id" do
      institute = institute_fixture()
      assert Institutes.get_institute!(institute.id) == institute
    end

    test "create_institute/1 with valid data creates a institute" do
      assert {:ok, %Institute{} = institute} = Institutes.create_institute(@valid_attrs)
      assert institute.cnpj == "some cnpj"
      assert institute.name == "some name"
      assert institute.type == "some type"
    end

    test "create_institute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Institutes.create_institute(@invalid_attrs)
    end

    test "update_institute/2 with valid data updates the institute" do
      institute = institute_fixture()
      assert {:ok, %Institute{} = institute} = Institutes.update_institute(institute, @update_attrs)
      assert institute.cnpj == "some updated cnpj"
      assert institute.name == "some updated name"
      assert institute.type == "some updated type"
    end

    test "update_institute/2 with invalid data returns error changeset" do
      institute = institute_fixture()
      assert {:error, %Ecto.Changeset{}} = Institutes.update_institute(institute, @invalid_attrs)
      assert institute == Institutes.get_institute!(institute.id)
    end

    test "delete_institute/1 deletes the institute" do
      institute = institute_fixture()
      assert {:ok, %Institute{}} = Institutes.delete_institute(institute)
      assert_raise Ecto.NoResultsError, fn -> Institutes.get_institute!(institute.id) end
    end

    test "change_institute/1 returns a institute changeset" do
      institute = institute_fixture()
      assert %Ecto.Changeset{} = Institutes.change_institute(institute)
    end
  end
end
