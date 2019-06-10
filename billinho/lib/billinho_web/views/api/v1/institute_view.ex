defmodule BillinhoWeb.Api.V1.InstituteView do
  use BillinhoWeb, :view
  alias BillinhoWeb.Api.V1.InstituteView

  def render("index.json", %{institutes: institutes}) do
    %{data: render_many(institutes, InstituteView, "institute.json")}
  end

  def render("show.json", %{institute: institute}) do
    %{data: render_one(institute, InstituteView, "institute.json")}
  end

  def render("institute.json", %{institute: institute}) do
    %{
      id: institute.id,
      name: institute.name,
      cnpj: institute.cnpj,
      type: institute.type
    }
  end
end
