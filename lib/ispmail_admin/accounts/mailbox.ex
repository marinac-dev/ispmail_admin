defmodule IspmailAdmin.Accounts.Mailbox do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mailboxes" do
    field :address, :string
    field :password, :string
    belongs_to :domain, IspmailAdmin.Accounts.Domain

    timestamps()
  end

  @doc false
  def changeset(mailbox, attrs) do
    mailbox
    |> cast(attrs, [:address, :password, :domain_id])
    |> validate_required([:address, :password, :domain_id])
    |> unique_constraint(:address)
  end
end
