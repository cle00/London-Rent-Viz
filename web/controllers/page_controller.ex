defmodule LdnRent.PageController do
  use LdnRent.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
