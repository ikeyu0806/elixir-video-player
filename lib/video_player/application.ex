defmodule VideoPlayer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VideoPlayerWeb.Telemetry,
      VideoPlayer.Repo,
      {DNSCluster, query: Application.get_env(:video_player, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VideoPlayer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VideoPlayer.Finch},
      # Start a worker by calling: VideoPlayer.Worker.start_link(arg)
      # {VideoPlayer.Worker, arg},
      # Start to serve requests, typically the last entry
      VideoPlayerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VideoPlayer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VideoPlayerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
