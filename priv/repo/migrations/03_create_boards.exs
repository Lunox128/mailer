defmodule Jinx.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string
      add :avatar, {:array, :string}, default: []
      add :banner, {:array, :string}, default: []
      add :wallpaper, {:array, :string}, default: []

      add :post_count, :integer, default: 0
      add :post_count_hour, :integer, default: 0
      add :post_count_day, :integer, default: 0
      add :post_count_week, :integer, default: 0
      add :post_count_month, :integer, default: 0

      add :comment_count, :integer, default: 0
      add :comment_count_hour, :integer, default: 0
      add :comment_count_day, :integer, default: 0
      add :comment_count_week, :integer, default: 0
      add :comment_count_month, :integer, default: 0

      add :follower_count, :integer
      add :follower_name, :string
      
      add :group_id, references(:groups, on_delete: :delete_all)

      timestamps()
    end
  end
end
