defmodule LdnRent.NestoriaResultsController do
  use LdnRent.Web, :controller
  import Ecto.Query

  def index(conn, %{"bedroom_number" => bedroom_number}) do
    sub_query = from sq in LdnRent.Nestoria,
      distinct: sq.lister_url,
      select: [:place_name,
              :lister_url,
              :price,
              :datasource_name,
              :title,
              :price_type],
      where: fragment("cast(to_char(?, 'YYYYMMDD') AS INTEGER) >= (SELECT cast(to_char(max(inserted_at), 'YYYYMMDD') AS INTEGER) - 1 FROM nestoria)", sq.inserted_at),
      where: sq.bedroom_number == ^bedroom_number

      nestoria_results = Repo.all(sub_query)
      render conn, "index.json", nestoria_results: nestoria_results
    end
  end
