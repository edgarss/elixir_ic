defmodule ElixirIc.Factory do
  use ExMachina.Ecto, repo: ElixirIc.Repo

  use ElixirIc.Accounts.UserFactory
end
