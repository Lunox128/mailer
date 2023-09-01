defmodule Jinx.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :value, :integer
      add :type, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)
      add :comment_id, references(:comments, on_delete: :delete_all)

      timestamps()
    end

    create index(:votes, [:user_id])
    create index(:votes, [:post_id])
    create index(:votes, [:comment_id])
  end
end
