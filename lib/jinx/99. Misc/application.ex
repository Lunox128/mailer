defmodule Jinx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JinxWeb.Telemetry,
      # Start the Ecto repository
      Jinx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Jinx.PubSub},
      # Start Finch
      {Finch, name: Jinx.Finch},
      # Start the Endpoint (http/https)
      JinxWeb.Endpoint
      # Start a worker by calling: Jinx.Worker.start_link(arg)
      # {Jinx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jinx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JinxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
