defmodule Pedro.Repo.Migrations.Node do
  use Ecto.Migration

  def change do
    create table(:node) do
      add :name,       :string
      add :started_at, :datetime, null: false# default: Ecto.DateTime.local
      timestamps
    end
  end
end
