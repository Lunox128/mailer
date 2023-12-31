defmodule Jinx.Repo.Migrations.CreatePostTags do
  use Ecto.Migration

  def change do
    create table(:post_tags) do
      add :tag_id, references(:tags, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create index(:post_tags, [:post_id, :tag_id], unique: true)
  end
end
