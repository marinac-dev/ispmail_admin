defmodule IspmailAdmin.Repo.Migrations.CreateDomains do
  use Ecto.Migration

  def change do
    create table(:domains) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:domains, [:name])
    create index(:domains, [:user_id])
  end
end
