defmodule Jinx.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :room_type, :string
      add :board_id, references(:boards, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      add :current_user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:rooms, [:user_id])
    create index(:rooms, [:current_user_id])
    create index(:rooms, [:board_id])
  end
end