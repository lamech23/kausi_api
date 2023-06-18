# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :kausi_api,
  ecto_repos: [KausiApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :kausi_api, KausiApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: KausiApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: KausiApi.PubSub,
  live_view: [signing_salt: "3qaMZdah"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :kausi_api, KausiApiWeb.Auth.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "md-q9fkVg5bZK6KjH7RVVTHQQ"


  config :kausi_api, KausiApiWeb.Auth.Guardian,
  issuer: "kausi_api",
  secret_key: "wTZxTawoex4R8TZKdjORtSDqrt5GtIFpZHeI/zTRvjeccFLvk73RGHmR007dtx7U"

  config :arc,
  storage: Arc.Storage.Local

  config :kausi_api, KausiApi.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  port: 587,
  username: "lamechcruze@gmail.com",
  password: "Katindi1$",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1,

  uploads: [
    storage: Arc.Storage.Local,
    path: "uploads",
    prefix: "uploads/#{Application.get_env(:kausi_api, KausiApi.Endpoint)[:url][:path]}"
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
