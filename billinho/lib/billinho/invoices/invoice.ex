defmodule Billinho.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :due_date, :date
    field :price, :float
    field :status, :string
    field :enrollment_id, :id

    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:price, :due_date, :status])
    |> validate_required([:price, :due_date, :status])
    |> validate_inclusion(:status, ~w(Aberta Atrasada Paga))
  end
end
