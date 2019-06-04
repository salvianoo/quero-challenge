defmodule Billinho.Repo do
  use Ecto.Repo,
    otp_app: :billinho,
    adapter: Ecto.Adapters.Postgres
end
