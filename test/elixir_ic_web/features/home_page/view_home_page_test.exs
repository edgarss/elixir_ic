defmodule ElixirIcWeb.HomePage.ViewHomePageTest do
  use ElixirIcWeb.FeatureCase

  feature "view home page", %{session: session} do
    visit(session, Routes.page_path(ElixirIcWeb.Endpoint, :index))

    assert_has(session, Query.text("Welcome to Eds Elixir IC!"))
  end
end
