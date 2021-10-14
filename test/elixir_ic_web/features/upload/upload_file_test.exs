defmodule ElixirIcWeb.UploadFileTest do
  use ElixirIcWeb.FeatureCase

  feature "upload a file", %{session: session} do
    session
    |> login_with_user()
    |>visit(Routes.upload_path(ElixirIcWeb.Endpoint, :new))
    |>attach_file(Query.file_field("upload[file]"),
      path: "test/support/fixtures/csv/valid.csv")
    |> click(Query.button("Upload"))
    |> assert_has(Query.text("File processed successfully"))
  end
end
