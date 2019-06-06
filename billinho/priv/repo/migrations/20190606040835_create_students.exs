defmodule Billinho.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :birth_date, :date
      add :cpf, :string
      add :gender, :string
      add :name, :string
      add :payment_method, :string
      add :telephone, :decimal

      timestamps()
    end

    create unique_index(:students, [:cpf])
    create unique_index(:students, [:name])
  end
end
