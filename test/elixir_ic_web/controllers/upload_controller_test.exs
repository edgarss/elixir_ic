defmodule ElixirIc.UploadControllerTest do
  use ElixirIcWeb.ConnCase, async: true
  alias ElixirIc.Repo
  alias ElixirIc.Search.Keyword

  setup :register_and_log_in_user

  describe "GET new" do
    test "renders the new upload page", %{conn: conn} do
      response =
        conn
        |> get(Routes.upload_path(conn, :new))
        |> html_response(200)

      assert response =~ "Upload a new file!"
    end
  end

  describe "POST create" do
    test "creates keywords in db after valid csv file is processed", %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/valid.csv", filename: "upload.csv"}

      result_conn = post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})
      assert Repo.aggregate(Keyword, :count) == 2

      assert redirected_to(result_conn) == Routes.upload_path(conn, :new)
      assert get_flash(result_conn, :info) == "File processed successfully"
    end

    test "shows error when csv is not in correct format" , %{conn: conn} do
      upload = %Plug.Upload{path: "test/support/fixtures/csv/invalid.csv", filename: "upload.csv"}

      result_conn = post(conn, Routes.upload_path(conn, :create), %{upload: %{file: upload}})
      assert redirected_to(result_conn) == Routes.upload_path(conn, :new)
      assert get_flash(result_conn, :error) == "Some error occurred while processing the file"
    end
  end
end
