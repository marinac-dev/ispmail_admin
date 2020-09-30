# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ispmail_admin,
  ecto_repos: [IspmailAdmin.Repo]

# Configures the endpoint
config :ispmail_admin, IspmailAdminWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uYGaiZglyEwIDADCJYqWTsbK4o8+/xAdNBWqj1ZP//T1XqDhg4mHdSEKBYhbxrko",
  render_errors: [view: IspmailAdminWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: IspmailAdmin.PubSub,
  live_view: [signing_salt: "t/fxZxVq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
