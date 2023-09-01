defmodule Jinx.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :read, :boolean, default: false
    field :type, :string
    field :room_id, :id
    field :user_id, :id
    field :current_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:type, :read])
    |> validate_required([:type, :read])
  end
end
