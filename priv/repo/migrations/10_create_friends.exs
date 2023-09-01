defmodule Jinx.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :current_user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end
    create index(:friends, [:user_id])
    create index(:friends, [:current_user_id])
  end
end