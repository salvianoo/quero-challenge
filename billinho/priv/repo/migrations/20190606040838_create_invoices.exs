defmodule Billinho.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :due_date, :date
      add :price, :float
      add :status, :string, default: "Aberta"
      add :enrollment_id, references(:enrollments, on_delete: :delete_all)

      timestamps()
    end

    create index(:invoices, [:enrollment_id])
  end
end
