defmodule Work.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WorkWeb.Telemetry,
      # Start the Ecto repository
      Work.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Work.PubSub},
      # Start Finch
      {Finch, name: Work.Finch},
      # Start the Endpoint (http/https)
      WorkWeb.Endpoint
      # Start a worker by calling: Work.Worker.start_link(arg)
      # {Work.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Work.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WorkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
