defmodule Jinx.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :type, :string

      add :board_count, :integer, default: 0
      add :emoticon_count, :integer, default: 0

      timestamps()
    end
  end
end
