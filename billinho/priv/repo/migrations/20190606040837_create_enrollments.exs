defmodule Billinho.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :course_name, :string
      add :due_date, :integer
      add :total_invoices, :integer
      add :total_price, :float
      add :institute_id, references(:institutes, on_delete: :nothing)
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end

    create index(:enrollments, [:institute_id])
    create index(:enrollments, [:student_id])
  end
end
