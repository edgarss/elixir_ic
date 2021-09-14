defmodule ElixirIc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirIc.Repo,
      # Start the Telemetry supervisor
      ElixirIcWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirIc.PubSub},
      # Start the Endpoint (http/https)
      ElixirIcWeb.Endpoint,
      {Oban, oban_config()}
      # Start a worker by calling: ElixirIc.Worker.start_link(arg)
      # {ElixirIc.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirIc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirIcWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable crontab, queues, or plugins here.
  defp oban_config do
    Application.get_env(:elixir_ic, Oban)
  end
end
