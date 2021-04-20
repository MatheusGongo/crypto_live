defmodule Crypto.Client_2 do
  use WebSockex

  @url "wss://ws-feed.pro.coinbase.com"

  def start_link(products \\ []) do
    {:ok, pid} = WebSockex.start_link(@url, __MODULE__, :no_state)
    subscribe(pid, products)
    {:ok, pid}
  end

  def handle_connect(conn, state) do
    IO.puts("Connected!")
    {:ok, state}
  end

  def subscribtion_frame(products) do
    subscription_msg =
      %{
        type: "subscribe",
        product_ids: products,
        channels: ["matches"]
      }
      |> Jason.encode!()

    {:text, subscription_msg}
  end

  def subscribe(pid, products) do
    WebSockex.send_frame(pid, subscribtion_frame(products))
  end

  def handle_frame(_frame = {:text, msg}, state) do
    msg
    |> Jason.decode!()
    |> IO.inspect()

    {:ok, state}
  end

  def handle_frame({:text, msg}, state) do
    handle_msg(Jason.decode!(msg), state)
  end

  def handle_msg(%{"type" => "match"} = trade, state) do
    IO.inspect(trade)
    {:ok, state}
  end

  def handle_msg(_, state), do: {:ok, state}

  def handle_msg(msg, state) do
    case msg do
      %{"type" => "match"} = trade -> IO.inspect(trade)
      _ -> :ignore
    end

    {:ok, state}
  end

  def handle_disconnect(_conn, state) do
    IO.puts "disconnected"
    {:ok, state}
  end

end
