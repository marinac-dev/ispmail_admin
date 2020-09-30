use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise "Environment variable DATABASE_URL is missing. For example: ecto://USER:PASS@HOST/DATABASE"

config :ispmail_admin, IspmailAdmin.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise "Environment variable SECRET_KEY_BASE is missing. You can generate one by calling: mix phx.gen.secret"

config :ispmail_admin, IspmailAdminWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

  config :ispmail_admin,
  live_dashboard: [
    username: "admin",
    password: "YOUR_PASSWORD",
    realm: "Do you even sudo bro?"
  ]
