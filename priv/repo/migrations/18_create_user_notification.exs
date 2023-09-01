defmodule Jinx.Repo.Migrations.CreateUserNotifications do
  use Ecto.Migration

  def change do
    create table(:user_notifications) do
      add :type, :string
      add :read, :boolean, default: false, null: false
      add :current_user_id, references(:users, on_delete: :delete_all)
      add :notification_id, references(:notifications, on_delete: :delete_all)

      timestamps()
    end
  end
end
