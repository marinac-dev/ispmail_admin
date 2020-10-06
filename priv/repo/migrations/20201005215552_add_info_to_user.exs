defmodule IspmailAdmin.Repo.Migrations.AddInfoToUser do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :first_name, :string, size: 100
      add :middle_name, :string, size: 100
      add :last_name, :string, size: 100
    end
  end
end
