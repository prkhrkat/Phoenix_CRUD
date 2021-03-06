# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :my_app,
  ecto_repos: [MyApp.Repo]

# Configures the endpoint
config :my_app, MyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "c02sheUEap7SeaSVglB8Ng7i0MMD8BCtdeQqaTOtyGcDST1SoomS5koRtn5GBTND",
  render_errors: [view: MyAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MyApp.PubSub,
  live_view: [signing_salt: "cmVkBcxj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :my_app, :pow,
  user: MyApp.Users.User,
  repo: MyApp.Repo,
  web_module: MyAppWeb,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: MyAppWeb.Pow.Mailer,
  web_mailer_module: MyAppWeb

config :my_app, :pow_assent,
  providers: [
    github: [
      client_id: "GITHUB_CLIENT_ID",
      client_secret: "GITHUB_CLIENT_SECRET",
      strategy: Assent.Strategy.Github
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
