defmodule LdnRent.UndergroundRoutesController do
  use LdnRent.Web, :controller
  alias LdnRent.UndergroundRoutes

  def index(conn, _params) do
    underground_routes = Repo.all(UndergroundRoutes)
    render conn, "index.json", underground_routes: underground_routes
  end
end
