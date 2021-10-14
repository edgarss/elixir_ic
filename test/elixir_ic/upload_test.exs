defmodule ElixirIc.Search.UploadTest do
  use ElixirIc.DataCase
  alias ElixirIc.Repo
  alias ElixirIc.Search.Keyword

  describe "#process_upload/2" do
    test "creates the keywords if file is properly formated" do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "valid.csv"}
      user = insert(:user)

      result = ElixirIc.Search.Upload.process(user, upload)

      assert {:ok,
              %{
                {:keyword, "Latvia"} => %Keyword{},
                {:keyword, " travel"} => %Keyword{}
              }} = result

      [first_keyword, second_keyword] = Repo.all(Keyword)
      assert first_keyword.name == "Latvia"
      assert second_keyword.name == "travel"
    end

    test "does NOT create keywords when file cannot be processed" do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "invalid.csv"}
      user = insert(:user)

      result = ElixirIc.Search.Upload.process(user, upload)

      assert {:error, {:keyword, ""}, _changeset, %{}} = result

      assert Repo.aggregate(Keyword, :count) == 0
    end
  end
end
