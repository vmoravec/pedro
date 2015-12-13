defmodule Pedro.Repo.Migrations.Node do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :name,       :string, unique: true, null: false
      add :type,       :string
      add :started_at, :datetime, null: false
      timestamps
    end
    create unique_index(:nodes, [:name, :type])
  end
end
