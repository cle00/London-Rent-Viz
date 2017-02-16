defmodule LdnRent.NestoriaResultsView do
  use LdnRent.Web, :view

  def render("index.json", %{nestoria_results: nestoria_results}) do
    nestoria_results
    |> Enum.map(&nestoria_results_json/1)
  end

  def nestoria_results_json(flats) do
    %{
      place_name: flats.place_name,
      lister_url: flats.lister_url,
      price: flats.price,
      datasource_name: flats.datasource_name,
      title: flats.title,
      price_type: flats.price_type
    }
  end
end
