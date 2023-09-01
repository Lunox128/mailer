defmodule Jinx.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :type, :string
      add :read, :boolean, default: false, null: false
      add :room_id, references(:rooms, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :current_user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:notifications, [:room_id])
    create index(:notifications, [:user_id])
    create index(:notifications, [:current_user_id])
  end
end
