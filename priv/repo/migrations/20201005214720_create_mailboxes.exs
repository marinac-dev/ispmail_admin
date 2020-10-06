defmodule IspmailAdmin.Repo.Migrations.CreateMailboxes do
  use Ecto.Migration

  def change do
    create table(:mailboxes) do
      add :address, :string
      add :password, :string
      add :domain_id, references(:domains, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:mailboxes, [:address])
    create index(:mailboxes, [:domain_id])
  end
end
