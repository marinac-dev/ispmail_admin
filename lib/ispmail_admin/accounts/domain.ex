defmodule IspmailAdmin.Accounts.Domain do
  use Ecto.Schema
  import Ecto.Changeset

  schema "domains" do
    field :name, :string
    belongs_to :user, IspmailAdmin.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(domain, attrs) do
    domain
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> unique_constraint(:name)
  end
end
