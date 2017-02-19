# Visualising the London rental market

This app attempts to give some context to the value proposition of living near to underground stations in London. Mouse over the stations on the map to see average rental prices for flats within 1 mile of the station. Data extracted from the [`nestoria`](www.nestoria.co.uk) API.

#### Technical spec:

  * The app is written using [`Elixir`](http://elixir-lang.org/) with the [`Phoenix web framework`](http://www.phoenixframework.org/)
  * [`d3.js`](https://d3js.org/) is used to generate the map, with this [`gist`](https://bl.ocks.org/nicola/69730fc4180246b0d56d) used as a base
  * [`React.js`](https://facebook.github.io/react/) & [`mobx`](https://mobx.js.org/) (state management) used for the interactive aspects, e.g. tables

#### To start the app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
