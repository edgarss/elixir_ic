defmodule ElixirIc.Search.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  schema "keywords" do
    field :name, :string

    field :status, Ecto.Enum,
      default: :pending,
      values: [pending: 0, started: 1, failed: 2, finished: 3]

    field :user_id, :id

    timestamps()
  end

  def changeset(keyword, attrs) do
    keyword
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
