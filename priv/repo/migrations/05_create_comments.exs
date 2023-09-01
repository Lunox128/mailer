defmodule Jinx.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :board_id, references(:boards, on_delete: :delete_all)

      add :body, :string, size: 1000

      add :post_id, references(:posts, on_delete: :delete_all)
      add :ancestor_id, references(:comments, on_dalete: :delete_all)
      add :parent_id, references(:comments, on_delete: :delete_all)
      
      add :depth, :integer, default: 0
      add :vote_count, :integer, default: 0
      add :reply_count, :integer, default: 0
      
      add :deleted, :boolean, default: false
      
      add :media_url, {:array, :string}, default: []
      add :media_type, :string

      timestamps()
    end

    create index(:comments, [:post_id])
    create index(:comments, [:user_id])
  end
end
