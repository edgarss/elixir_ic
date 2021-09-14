# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_ic,
  ecto_repos: [ElixirIc.Repo]

# Configures the endpoint
config :elixir_ic, ElixirIcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0aykqeQr/u5tn6IGX3bdp4zTcyTf+BFyFhAXHg6iM/Jc3UNBfcDR/GAqS9fIukSN",
  render_errors: [view: ElixirIcWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirIc.PubSub,
  live_view: [signing_salt: "87m6ce3z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_ic, Oban,
  repo: ElixirIc.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
