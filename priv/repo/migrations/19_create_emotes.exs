defmodule Jinx.Repo.Migrations.CreateEmotes do
  use Ecto.Migration

  def change do
    create table(:emotes) do
      add :name, :string
      add :image, :string

      add :user_id, references(:users, on_delete: :delete_all)
      add :board_id, references(:boards, on_delete: :delete_all)
      add :group_id, references(:groups, on_delete: :delete_all)

      timestamps()
    end

    create index(:emotes, [:user_id])
    create index(:emotes, [:board_id])
  end
end
