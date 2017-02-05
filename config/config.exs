# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ldn_rent,
  ecto_repos: [LdnRent.Repo]

# Configures the endpoint
config :ldn_rent, LdnRent.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fNhuIxphT55LzZWqC+V2ri/bvu7k9qU2+E9BQigMt1npm/ITNsqWpHifLs/MBb5G",
  render_errors: [view: LdnRent.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LdnRent.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
