defmodule HelloHtmx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloHtmxWeb.Telemetry,
      HelloHtmx.Repo,
      {DNSCluster, query: Application.get_env(:hello_htmx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloHtmx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloHtmx.Finch},
      # Start a worker by calling: HelloHtmx.Worker.start_link(arg)
      # {HelloHtmx.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloHtmxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloHtmx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloHtmxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
