defmodule CryptoLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @app_env Mix.env()

  def start(_type, _args) do
    children =
      [
        CryptoLiveWeb.Telemetry,
        {Phoenix.PubSub, name: CryptoLive.PubSub},
        {CryptoLive.Historical, name: CryptoLive.Historical},
        CryptoLiveWeb.Endpoint
      ] ++
        exchanges_supervisor_unless_testing()

    opts = [strategy: :one_for_one, name: CryptoLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CryptoLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp exchanges_supervisor_unless_testing do
    if @app_env == :test,
      do: [],
      else: [{CryptoLive.Exchanges.Supervisor, name: CryptoLive.Exchanges.Supervisor}]
  end
end
