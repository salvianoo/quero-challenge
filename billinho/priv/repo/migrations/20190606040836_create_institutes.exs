defmodule Billinho.Repo.Migrations.CreateInstitutes do
  use Ecto.Migration

  def change do
    create table(:institutes) do
      add :cnpj, :string
      add :name, :string
      add :type, :string

      timestamps()
    end

    create unique_index(:institutes, [:cnpj])
    create unique_index(:institutes, [:name])
  end
end
