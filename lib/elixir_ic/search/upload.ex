defmodule ElixirIc.Search.Upload do
  alias Ecto.Multi
  alias ElixirIc.Accounts.User
  alias ElixirIc.Repo
  alias ElixirIc.Search.Keyword

  @max_keywords 100

  def process(%User{} = user, %Plug.Upload{} = upload) do
    upload.path
    |> keyword_values()
    |> Enum.reduce(Multi.new(), fn name, multi ->
      Multi.insert(
        multi,
        {:keyword, name},
        Keyword.changeset(%Keyword{}, %{name: String.trim(name), user: user})
      )
    end)
    |> Repo.transaction()
  end

  defp keyword_values(upload_path) do
    upload_path
    |> File.stream!()
    |> CSV.decode!(seperator: ",")
    |> Enum.take(@max_keywords)
    |> List.flatten()
  end
end
