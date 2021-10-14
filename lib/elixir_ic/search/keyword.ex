defmodule ElixirIc.Search.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirIc.Accounts.User

  schema "keywords" do
    field :name, :string

    field :status, Ecto.Enum,
      default: :pending,
      values: [pending: 0, started: 1, failed: 2, finished: 3]

    belongs_to :user, User

    timestamps()
  end

  def changeset(keyword, attrs) do
    keyword
    |> cast(attrs, [:name])
    |> put_assoc(:user, attrs[:user])
    |> validate_required([:name, :user])
  end
end
