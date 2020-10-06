defmodule IspmailAdminWeb.DomainController do
  use IspmailAdminWeb, :controller

  alias IspmailAdmin.Accounts
  alias IspmailAdmin.Accounts.Domain

  def index(conn, _params) do
    domains = Accounts.list_domains()
    render(conn, "index.html", domains: domains)
  end

  def new(conn, _params) do
    changeset = Accounts.change_domain(%Domain{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"domain" => %{"default_email" => default_email} = domain_params}) do
    user = conn.assigns.current_user
    domain_params = Map.merge(domain_params, %{"user_id" => user.id})

    case Accounts.create_domain(domain_params) do
      {:ok, domain} ->
        default_alias(domain, default_email)

        conn
        |> put_flash(:info, "Domain created successfully.")
        |> redirect(to: Routes.domain_path(conn, :show, domain))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp default_alias(_, "false"), do: :ok

  defp default_alias(domain, "true") do
    def_alias = ["admin", "postmaster", "abuse"]

    Accounts.create_mailbox(%{
      address: "admin@" <> domain.name,
      domain_id: domain.id,
      password: "password"
    })

    Enum.map(def_alias, fn el ->
      Accounts.create_alias(%{
        source: el,
        destination: "admin@" <> domain.name,
        domain_id: domain.id
      })
    end)
  end

  def show(conn, %{"id" => id}) do
    domain = Accounts.get_domain!(id)
    render(conn, "show.html", domain: domain)
  end

  def edit(conn, %{"id" => id}) do
    domain = Accounts.get_domain!(id)
    changeset = Accounts.change_domain(domain)
    render(conn, "edit.html", domain: domain, changeset: changeset)
  end

  def update(conn, %{"id" => id, "domain" => domain_params}) do
    domain = Accounts.get_domain!(id)

    case Accounts.update_domain(domain, domain_params) do
      {:ok, domain} ->
        conn
        |> put_flash(:info, "Domain updated successfully.")
        |> redirect(to: Routes.domain_path(conn, :show, domain))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", domain: domain, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    domain = Accounts.get_domain!(id)
    {:ok, _domain} = Accounts.delete_domain(domain)

    conn
    |> put_flash(:info, "Domain deleted successfully.")
    |> redirect(to: Routes.domain_path(conn, :index))
  end
end
