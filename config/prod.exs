use Mix.Config

config :ispmail_admin, IspmailAdminWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info

# Import the config/prod.secret.exs which loads secrets
import_config "prod.secret.exs"
