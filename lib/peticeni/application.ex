defmodule Peticeni.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PeticeniWeb.Telemetry,
      # Start the Ecto repository
      Peticeni.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Peticeni.PubSub},
      # Start Finch
      {Finch, name: Peticeni.Finch},
      # Start the Endpoint (http/https)
      PeticeniWeb.Endpoint
      # Start a worker by calling: Peticeni.Worker.start_link(arg)
      # {Peticeni.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Peticeni.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PeticeniWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
