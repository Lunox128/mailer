defmodule Jinx.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :follow_active, :boolean, default: true
      add :follow_type, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :current_user_id, references(:users, on_delete: :delete_all)
      add :board_id, references(:boards, on_delete: :delete_all)

      timestamps()
    end

    create index(:follows, [:follow_active, :user_id, :current_user_id], unique: true)
  end
end