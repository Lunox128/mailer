defmodule Jinx.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :type, :string
      add :color, :string

      add :user_id, references(:users, on_delete: :delete_all)
      add :board_id, references(:boards, on_delete: :delete_all)
      add :group_id, references(:groups, on_delete: :delete_all)

      add :tag_count_hour, :integer, default: 0
      add :tag_count_day, :integer, default: 0
      add :tag_count_week, :integer, default: 0
      add :tag_count_month, :integer, default: 0

      timestamps()
    end
    
    create index(:tags, [:name])
  end
end
