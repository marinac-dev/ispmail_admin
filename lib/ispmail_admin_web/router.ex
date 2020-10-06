defmodule IspmailAdminWeb.Router do
  use IspmailAdminWeb, :router

  import IspmailAdminWeb.User.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IspmailAdminWeb do
    pipe_through [:browser]

    get "/", PageController, :index

    # Log out and confirm e-mail
    delete "/log_out", User.SessionController, :delete
    get "/confirm", User.ConfirmationController, :new
    post "/confirm", User.ConfirmationController, :create
    get "/confirm/:token", User.ConfirmationController, :confirm
  end

  # Authentication routes
  scope "/", IspmailAdminWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    # Register
    get "/register", User.RegistrationController, :new
    post "/register", User.RegistrationController, :create
    # Log in
    get "/log_in", User.SessionController, :new
    post "/log_in", User.SessionController, :create
    # Reset password
    get "/reset_password", User.ResetPasswordController, :new
    post "/reset_password", User.ResetPasswordController, :create
    get "/reset_password/:token", User.ResetPasswordController, :edit
    put "/reset_password/:token", User.ResetPasswordController, :update
  end

  scope "/", IspmailAdminWeb do
    pipe_through [:browser, :require_authenticated_user]

    # Account
    get "/account", PageController, :account

    # Domain & mailbox
    resources "/domains", DomainController do
      resources "/aliases", AliasController
      resources "/mailboxes", MailboxController
    end

    # User settings
    get "/settings", User.SettingsController, :edit
    put "/settings/update_password", User.SettingsController, :update_password
    put "/settings/update_email", User.SettingsController, :update_email
    get "/settings/confirm_email/:token", User.SettingsController, :confirm_email
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
