defmodule TaskManagement.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TaskManagementWeb.Telemetry,
      TaskManagement.Repo,
      {DNSCluster, query: Application.get_env(:taskManagement, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TaskManagement.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TaskManagement.Finch},
      # Start a worker by calling: TaskManagement.Worker.start_link(arg)
      # {TaskManagement.Worker, arg},
      # Start to serve requests, typically the last entry
      TaskManagementWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TaskManagement.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TaskManagementWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
