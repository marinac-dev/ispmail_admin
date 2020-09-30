defmodule IspmailAdminWeb.PageController do
  use IspmailAdminWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
