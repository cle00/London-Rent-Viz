defmodule LdnRent.UndergroundStationsController do
  use LdnRent.Web, :controller
  import Ecto.Query

  def index(conn, _params) do
    sub_query = from sq in LdnRent.Nestoria,
      distinct: sq.lister_url,
      select: [:place_name,
              :price,
              :price_type],
      where: fragment("cast(to_char(?, 'YYYYMMDD') AS INTEGER) >= (SELECT cast(to_char(max(inserted_at), 'YYYYMMDD') AS INTEGER) - 1 FROM nestoria)", sq.inserted_at),
      where: sq.bedroom_number == 1

    query = from un in LdnRent.Underground,
      left_join: ne in subquery(sub_query), on: un.station_name_slug == ne.place_name,
      select: [	un.lines_id,
                un.station_name,
                un.display_name,
                un.latitude,
                un.longitude,
                un.zone,
                un.total_lines,
                un.rail,
                ne.place_name,
                fragment("count(?) as data_count", ne.place_name),
                fragment("Avg(CASE WHEN ? = 'weekly' THEN price * ( 31 / 7 ) ELSE price END) AS avg_monthly_price ", ne.price_type)],
      group_by: [un.lines_id,
                un.station_name,
                un.display_name,
                un.latitude,
                un.longitude,
                un.zone,
                un.total_lines,
                un.rail,
                ne.place_name],
      order_by: [ne.place_name]

    underground_stations = Repo.all(query)
    render conn, "index.json", underground_stations: underground_stations
  end
end
