defmodule CryptoLive do
  defdelegate available_products(), to: CryptoLive.Exchanges

  defdelegate subscribe_to_trades(product), to: CryptoLive.Exchanges, as: :subscribe

  defdelegate unsubcribe_from_trades(product), to: CryptoLive.Exchanges, as: :unsubscribe

  defdelegate get_last_trade(product), to: CryptoLive.Historical
  defdelegate get_last_trades(products), to: CryptoLive.Historical
end
