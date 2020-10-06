defmodule IspmailAdmin.Accounts.Alias do
  use Ecto.Schema
  import Ecto.Changeset

  schema "aliases" do
    field :destination, :string
    field :source, :string
    belongs_to :domain, IspmailAdmin.Accounts.Domain

    timestamps()
  end

  @doc false
  def changeset(alias, attrs) do
    alias
    |> cast(attrs, [:source, :destination, :domain_id])
    |> validate_required([:source, :destination, :domain_id])
    |> unique_constraint(:source)
  end
end
