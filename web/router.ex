defmodule LdnRent.Router do
  use LdnRent.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LdnRent do
    pipe_through :api

    resources "/underground_routes", UndergroundRoutesController, only: [:index]
    resources "/underground_stations/:bedroom_number", UndergroundStationsController, only: [:index]
  end

  scope "/", LdnRent do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LdnRent do
  #   pipe_through :api
  # end
end
