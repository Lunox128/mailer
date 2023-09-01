defmodule Jinx.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      # Account Settings
      add :username, :citext, null: false
      add :display_name, :string, size: 25
      add :role, :string, default: "User"
      add :account_status, :string, default: "Active"
      add :site_status, :string, default: "Active"
      add :exp, :integer, default: 0
      add :rank, :integer, default: 0
      add :target_room, :integer, default: 1
      add :nsfw, :boolean, default: false, null: false
      
      # Account Metrics
      add :view_count, :integer, default: 0
      add :message_count, :integer, default: 0
      add :notification_count, :integer, default: 0
      add :vote_count, :integer, default: 0
      add :post_count, :integer, default: 0
      add :friend_count, :integer, default: 0
      add :follower_count, :integer, default: 0
      add :following_count, :integer, default: 0
      add :repost_count, :integer, default: 0
      add :engagement_count, :integer, default: 0
      add :engagement_average, :integer, default: 0

      # Profile Settings
      add :about, :string
      add :avatar, {:array, :string}, default: []
      add :banner, {:array, :string}, default: []
      add :disable_banners, :boolean, default: false, null: false
      add :wallpaper, {:array, :string}, default: []
      add :primary_theme, :string, default: "Dark"
      add :secondary_theme, :string, default: "Jinx"
      add :sort, :string, default: "New"

      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime

      timestamps()
    end

    create unique_index(:users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end