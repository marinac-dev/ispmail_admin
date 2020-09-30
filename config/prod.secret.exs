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

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :ispmail_admin, IspmailAdminWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.

config :ispmail_admin,
  live_dashboard: [
    username: "admin",
    password: "3pg#9hwjf%f5yc6JYRvgl&#as!1#SDI6",
    realm: "Do you even sudo bro?"
  ]
