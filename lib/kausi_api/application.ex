defmodule KausiApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KausiApiWeb.Telemetry,
      # Start the Ecto repository
      KausiApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: KausiApi.PubSub},
      # Start the Endpoint (http/https)
      KausiApiWeb.Endpoint,
      # Start a worker by calling: KausiApi.Worker.start_link(arg)
      # {KausiApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KausiApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KausiApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
