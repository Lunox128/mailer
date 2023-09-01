defmodule Jinx.Repo.Migrations.CreateMessengerSettings do
  use Ecto.Migration

  def change do
    create table(:messenger_settings) do
      add :user_id, references(:users, on_delete: :delete_all)

      add :messenger_availability, :string, default: "Available"
      add :messenger_privacy, :string, default: "Everyone"
      add :messenger_requests, :boolean, default: true, null: false
      add :messenger_style, :integer, default: 0
      
      add :font_size, :integer, default: 1
      add :timestamps, :boolean, default: true, null: false

      add :nsfw_mode, :boolean, default: true

      timestamps()
    end

    create index(:messenger_settings, [:user_id])
  end
end
