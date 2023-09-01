defmodule Jinx.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :board_id, references(:boards, on_delete: :delete_all)
      
      add :title, :string, size: 100
      add :body, :string, size: 4000
      add :privacy, :string, default: "Public"
      
      add :vote_count, :integer, default: 0
      add :vote_count_hour, :integer, default: 0
      add :vote_count_day, :integer, default: 0
      add :vote_count_week, :integer, default: 0
      add :vote_count_month, :integer, default: 0

      add :comment_count, :integer, default: 0
      add :comment_count_hour, :integer, default: 0
      add :comment_count_day, :integer, default: 0
      add :comment_count_week, :integer, default: 0
      add :comment_count_month, :integer, default: 0

      add :view_count, :integer, default: 0     
      add :view_count_hour, :integer, default: 0
      add :view_count_day, :integer, default: 0
      add :view_count_week, :integer, default: 0
      add :view_count_month, :integer, default: 0
      
      add :deleted, :boolean, default: false
      add :nsfw, :boolean, default: false
      add :poll, :boolean, default: false
      add :spoiler, :boolean, default: false

      add :poll_question, :string

      add :image_url, {:array, :string}, default: []
      add :video_url, {:array, :string}, default: []
      add :media_type, :string, deafult: "No Media"
      

      timestamps()
    end

    create index(:posts, [:user_id])
    create index(:posts, [:board_id])
  end
end