defmodule LdnRent.UndergroundStationsView do
  use LdnRent.Web, :view

  def render("index.json", %{underground_stations: underground_stations}) do
    underground_stations
    |> Enum.map(&underground_stations_json/1)
  end

  def underground_stations_json(underground_stations) do
    [lines_id,
    station_name,
    display_name,
    latitude,
    longitude,
    zone,
    total_lines,
    rail,
    place_name,
    data_count,
    avg_monthly_price
    ] = underground_stations
    %{
      id: lines_id,
      station_name: station_name,
      display_name: display_name,
      latitude: latitude,
      place_name: place_name,
      longitude: longitude,
      zone: zone,
      total_lines: total_lines,
      rail: rail,
      data_count: data_count,
      avg_monthly_price: avg_monthly_price
    }
  end
end
