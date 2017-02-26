defmodule LdnRent.UndergroundStopChannel do
  import Ecto.Query
  use LdnRent.Web, :channel

  def join("underground_stop:" <> stop_id, _params, socket) do
    IO.inspect stop_id
    query = from sq in LdnRent.Nestoria,
      distinct: fragment("cast(to_char(?, 'YYYYMMDD') AS INTEGER)", sq.inserted_at),
      select: [sq.inserted_at,
              fragment("Avg(CASE WHEN ? = 'weekly' THEN ? * ( 31 / 7 ) ELSE ? END) AS price", sq.price_type, sq.price, sq.price)],
      where: sq.bedroom_number == 1 and sq.place_name == ^stop_id,
      group_by: [sq.inserted_at],
      order_by: sq.inserted_at

    timeseries = Repo.all(query)
    timeseries_json = Enum.map(timeseries, &timeseries_json/1)
    resp = %{timeseries: timeseries_json}

    {:ok, resp, assign(socket, :stop_id, stop_id)}
  end

  def join("underground_stop:", _params, socket) do
    {:ok, %{timeseries: "N/A"}, assign(socket, :stop_id, "N/A")}
  end

  defp timeseries_json(timeseries) do
    [inserted_at,
    price,
    ] = timeseries
    %{
      inserted_at: inserted_at,
      price: price
    }
  end
end
