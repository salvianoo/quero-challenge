defmodule Billinho.Enrollments.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "enrollments" do
    field :course_name, :string
    field :due_date, :integer
    field :total_invoices, :integer
    field :total_price, :float
    # field :institute_id, :id
    # field :student_id, :id
    belongs_to :institute, Billinho.Institutes.Institute
    belongs_to :student, Billinho.Students.Student

    has_many :invoices, Billinho.Invoices.Invoice

    timestamps()
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> cast(attrs, [:total_price, :total_invoices, :due_date, :course_name])
    # |> cast_assoc(:invoices, required: true)
    |> validate_required([:total_price, :total_invoices, :due_date, :course_name])
    |> validate_number(:total_price, greater_than: 0)
    |> validate_number(:total_invoices, greater_than_or_equal_to: 0)
    |> validate_number(:total_invoices, greater_than_or_equal_to: 0)
    |> validate_inclusion(:due_date, 1..31)
    |> assoc_constraint(:student)
    |> assoc_constraint(:institute)
    # |> put_assoc(:student, attrs.student)
    # |> validate_number(:due_date, greater_than_or_equal_to: 1, less_than_or_equal_to: 31)
  end
end
