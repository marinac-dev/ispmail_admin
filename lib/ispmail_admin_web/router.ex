defmodule IspmailAdminWeb.Router do
  use IspmailAdminWeb, :router

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

  scope "/", IspmailAdminWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  pipeline :dashboard_auth do
    import Plug.BasicAuth
    plug :basic_auth, Application.compile_env(:ispmail_admin, :live_dashboard)
  end

  # Use LiveDashboard because why not :)
  scope "/" do
    import Phoenix.LiveDashboard.Router

    pipe_through [:browser, :dashboard_auth]
    live_dashboard "/dashboard", metrics: IspmailAdminWeb.Telemetry
  end
end
