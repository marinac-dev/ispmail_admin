defmodule IspmailAdmin.Repo.Migrations.CreateAliases do
  use Ecto.Migration

  def change do
    create table(:aliases) do
      add :source, :string
      add :destination, :string
      add :domain_id, references(:domains, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:aliases, [:source])
    create index(:aliases, [:domain_id])
  end
end
