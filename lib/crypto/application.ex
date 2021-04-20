defmodule CryptoLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CryptoLive.Repo,
      {CryptoLive.Client, ["BTC-USD"]},
      # Start the Telemetry supervisor
      CryptoLiveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CryptoLive.PubSub},
      # Start the Endpoint (http/https)
      CryptoLiveWeb.Endpoint
      # Start a worker by calling: CryptoLive.Worker.start_link(arg)
      # {CryptoLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CryptoLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CryptoLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
