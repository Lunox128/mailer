defmodule Jinx.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :status, :string, default: "unblocked"
      add :user_id, references(:users, on_delete: :delete_all)
      add :current_user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:blocks, [:user_id])
    create index(:blocks, [:current_user_id])
  end
end
