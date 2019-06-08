defmodule Billinho.InstitutesTest do
  use Billinho.DataCase

  alias Billinho.Institutes

  describe "institutes" do
    alias Billinho.Institutes.Institute

    @valid_attrs %{cnpj: "94988448000109", name: "Universidade de Winterfell", type: "Universidade"}
    @update_attrs %{cnpj: "90517134000177", name: "Escola de Idiomas Jedi", type: "Escola"}
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
      assert institute.cnpj == "94988448000109"
      assert institute.name == "Universidade de Winterfell"
      assert institute.type == "Universidade"
    end

    test "create_institute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Institutes.create_institute(@invalid_attrs)
    end

    test "update_institute/2 with valid data updates the institute" do
      institute = institute_fixture()
      assert {:ok, %Institute{} = institute} = Institutes.update_institute(institute, @update_attrs)
      assert institute.cnpj == "90517134000177"
      assert institute.name == "Escola de Idiomas Jedi"
      assert institute.type == "Escola"
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
