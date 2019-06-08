defmodule Billinho.Enrollments do
  @moduledoc """
  The Enrollments context.
  """

  import Ecto.Query, warn: false
  alias Billinho.Repo

  alias Billinho.Enrollments.Enrollment
  alias Billinho.Students.Student
  alias Billinho.Institutes.Institute
  alias Billinho.Invoices.Invoice

  alias Billinho.Invoices

  @doc """
  Returns the list of enrollments.

  ## Examples

      iex> list_enrollments()
      [%Enrollment{}, ...]

  """
  def list_enrollments do
    Enrollment
    |> Repo.all()
    |> preload_student()
    |> preload_institute()
  end

  @doc """
  Gets a single enrollment.

  Raises `Ecto.NoResultsError` if the Enrollment does not exist.

  ## Examples

      iex> get_enrollment!(123)
      %Enrollment{}

      iex> get_enrollment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_enrollment!(id) do
    Repo.get!(Enrollment, id)
    |> preload_student()
    |> preload_institute()
  end

  @doc """
  Creates a enrollment.

  ## Examples

      iex> create_enrollment(%{field: value})
      {:ok, %Enrollment{}}

      iex> create_enrollment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_enrollment(attrs \\ %{}, %Student{} = student, %Institute{} = institute) do
    %Enrollment{}
    |> Enrollment.changeset(attrs)
    |> put_student(student)
    |> put_institute(institute)
    |> build_invoices(attrs.total_invoices)
    |> Repo.insert()
  end

  @doc """
  Updates a enrollment.

  ## Examples

      iex> update_enrollment(enrollment, %{field: new_value})
      {:ok, %Enrollment{}}

      iex> update_enrollment(enrollment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_enrollment(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> Enrollment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Enrollment.

  ## Examples

      iex> delete_enrollment(enrollment)
      {:ok, %Enrollment{}}

      iex> delete_enrollment(enrollment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_enrollment(%Enrollment{} = enrollment) do
    Repo.delete(enrollment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enrollment changes.

  ## Examples

      iex> change_enrollment(enrollment)
      %Ecto.Changeset{source: %Enrollment{}}

  """
  def change_enrollment(%Enrollment{} = enrollment) do
    Enrollment.changeset(enrollment, %{})
  end

  defp put_student(changeset, student) do
    Ecto.Changeset.put_assoc(changeset, :student, student)
  end

  defp put_institute(changeset, institute) do
    Ecto.Changeset.put_assoc(changeset, :institute, institute)
  end

  defp preload_student(enrollment_or_enrollments) do
    Repo.preload(enrollment_or_enrollments, :student)
  end

  defp preload_institute(institute_or_institutes) do
    Repo.preload(institute_or_institutes, :institute)
  end

  defp build_invoices(changeset, total_invoices) do

    invoice_1 = %{price: 120.5, due_date: ~D[2019-06-21], status: "Aberta"}
    invoice_2 = %{price: 120.5, due_date: ~D[2019-07-21], status: "Aberta"}

    # invoice = Ecto.Changeset.change(%Invoice{}, invoice_attrs)

    invoices = [
      Ecto.Changeset.change(%Invoice{}, invoice_1),
      Ecto.Changeset.change(%Invoice{}, invoice_2)
    ]

    # invoice = Ecto.Changeset.change(%Invoice{}, invoice_attrs)
    # Ecto.Changeset.put_assoc(changeset, :invoices, [invoice])

    Ecto.Changeset.put_assoc(changeset, :invoices, invoices)

      #|> Invoices.create_invoice()
    # Ecto.Changeset.cast_assoc(changeset, :invoices, required: true)
    # Ecto.Changeset.put_assoc(changeset, :invoices, [invoice])
  end
end
