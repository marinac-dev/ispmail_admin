defmodule IspmailAdminWeb.MailboxController do
  use IspmailAdminWeb, :controller

  alias IspmailAdmin.Accounts
  alias IspmailAdmin.Accounts.Mailbox

  def index(conn, _params) do
    mailboxes = Accounts.list_mailboxes()
    render(conn, "index.html", mailboxes: mailboxes)
  end

  def new(conn, _params) do
    changeset = Accounts.change_mailbox(%Mailbox{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mailbox" => mailbox_params}) do
    case Accounts.create_mailbox(mailbox_params) do
      {:ok, mailbox} ->
        conn
        |> put_flash(:info, "Mailbox created successfully.")
        |> redirect(to: Routes.mailbox_path(conn, :show, mailbox))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mailbox = Accounts.get_mailbox!(id)
    render(conn, "show.html", mailbox: mailbox)
  end

  def edit(conn, %{"id" => id}) do
    mailbox = Accounts.get_mailbox!(id)
    changeset = Accounts.change_mailbox(mailbox)
    render(conn, "edit.html", mailbox: mailbox, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mailbox" => mailbox_params}) do
    mailbox = Accounts.get_mailbox!(id)

    case Accounts.update_mailbox(mailbox, mailbox_params) do
      {:ok, mailbox} ->
        conn
        |> put_flash(:info, "Mailbox updated successfully.")
        |> redirect(to: Routes.mailbox_path(conn, :show, mailbox))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mailbox: mailbox, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mailbox = Accounts.get_mailbox!(id)
    {:ok, _mailbox} = Accounts.delete_mailbox(mailbox)

    conn
    |> put_flash(:info, "Mailbox deleted successfully.")
    |> redirect(to: Routes.mailbox_path(conn, :index))
  end
end
