defmodule ElixirIc.Repo do
  use Ecto.Repo,
    otp_app: :elixir_ic,
    adapter: Ecto.Adapters.Postgres
end
