defmodule LdnRent.NestoriaResultsView do
  use LdnRent.Web, :view

  def render("index.json", %{nestoria_results: nestoria_results}) do
    nestoria_results
    |> Enum.map(&nestoria_results_json/1)
  end

  def nestoria_results_json(flats) do
    [
      place_name,
      lister_url,
      price,
      datasource_name,
      title,
      avg_monthly_price,
      price_type
    ] = flats
    %{
      place_name: place_name,
      lister_url: lister_url,
      price: price,
      avg_monthly_price: avg_monthly_price,
      datasource_name: datasource_name,
      title: title,
      price_type: price_type
    }
  end
end
