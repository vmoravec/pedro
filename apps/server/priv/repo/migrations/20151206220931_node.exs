defmodule Pedro.Repo.Migrations.Node do
  use Ecto.Migration

  def change do
    create table(:node) do
      add :name,       :string
      add :type,       :string
      add :started_at, :datetime, null: false
      timestamps
    end
  end
end
