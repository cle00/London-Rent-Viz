defmodule LdnRent.UndergroundRoutesView do
  use LdnRent.Web, :view

  def render("index.json", %{underground_routes: underground_routes}) do
    IO.inspect underground_routes
    underground_routes
    |> Enum.map(&underground_routes_json/1)
  end

  def underground_routes_json(underground_routes) do
    %{
      colour: underground_routes.colour,
      line: underground_routes.line,
      name: underground_routes.name,
      stripe: underground_routes.stripe
    }
  end
end
