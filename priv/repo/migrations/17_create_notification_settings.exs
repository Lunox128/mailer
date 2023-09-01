defmodule Jinx.Repo.Migrations.CreateNotificationSettings do
  use Ecto.Migration

  def change do
    create table(:notification_settings) do
      add :user_id, references(:users, on_delete: :delete_all)

      add :notifications, :boolean, default: true, null: false

      add :new_post, :boolean, deafult: true, null: false
      add :mentions, :boolean, default: true, null: false
      add :new_follower, :boolean, default: true, null: false
      add :friend_requests, :boolean, default: true, null: false

      add :post_upvotes, :boolean, default: true, null: false
      add :comment_upvotes, :boolean, default: true, null: false
      add :post_comments, :boolean, default: true, null: false
      add :comment_replies, :boolean, default: true, null: false

      timestamps()
    end

    create index(:notification_settings, [:user_id])
  end
end
