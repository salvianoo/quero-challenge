defmodule Billinho.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :birth_date, :date
    field :cpf, :string
    field :gender, :string
    field :name, :string
    field :payment_method, :string
    field :telephone, :decimal

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:birth_date, :cpf, :gender, :name, :payment_method, :telephone])
    |> validate_required([:birth_date, :cpf, :gender, :name, :payment_method, :telephone])
    |> validate_inclusion(:gender, ~w(M F))
    |> validate_inclusion(:payment_method, ~w(Boleto Cartão))
    |> unique_constraint(:cpf)
    |> unique_constraint(:name)
  end
end
