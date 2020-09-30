defmodule IspmailAdmin.Repo do
  use Ecto.Repo,
    otp_app: :ispmail_admin,
    adapter: Ecto.Adapters.Postgres
end
