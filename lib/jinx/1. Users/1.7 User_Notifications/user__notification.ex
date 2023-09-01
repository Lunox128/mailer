defmodule Jinx.User_Notifications.User_Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_notification" do
    field :read, :boolean, default: false
    field :type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user__notification, attrs) do
    user__notification
    |> cast(attrs, [:type, :read])
    |> validate_required([:type, :read])
  end
end
