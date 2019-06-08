defmodule Billinho.Institutes.Institute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "institutes" do
    field :cnpj, :string
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(institute, attrs) do
    institute
    |> cast(attrs, [:name, :cnpj, :type])
    |> validate_required([:name, :cnpj, :type])
    |> validate_format(:cnpj, ~r/^[0-9]+$/)
    |> validate_inclusion(:type, ~w(Universidade Escola Creche))
    |> unique_constraint(:name)
    |> unique_constraint(:cnpj)
  end
end
