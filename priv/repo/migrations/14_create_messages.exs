defmodule Jinx.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :room_id, references(:rooms, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      add :current_user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:room_id])
    create index(:messages, [:user_id])
    create index(:messages, [:current_user_id])
  end
end
