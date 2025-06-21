defmodule SeraphoRank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SeraphoRankWeb.Telemetry,
      SeraphoRank.Repo,
      {DNSCluster, query: Application.get_env(:serapho_rank, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SeraphoRank.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SeraphoRank.Finch},
      # Start a worker by calling: SeraphoRank.Worker.start_link(arg)
      # {SeraphoRank.Worker, arg},
      # Start to serve requests, typically the last entry
      SeraphoRankWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SeraphoRank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SeraphoRankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
