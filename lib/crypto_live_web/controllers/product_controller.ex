defmodule CryptoLiveWeb.ProductController do
  use CryptoLiveWeb, :controller

  def index(conn, _params) do
    trades =
      Cryptolive.available_products()
      |> Cryptolive.get_last_trades()

    render(conn, "index.html", trades: trades)
  end
end
