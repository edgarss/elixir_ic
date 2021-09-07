defmodule ElixirIcWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import ElixirIc.Factory

      alias ElixirIcWeb.Router.Helpers, as: Routes
    end
  end
end
