defmodule CryptoLive.Repo do
  use Ecto.Repo,
    otp_app: :crypto_live,
    adapter: Ecto.Adapters.MyXQL
end
