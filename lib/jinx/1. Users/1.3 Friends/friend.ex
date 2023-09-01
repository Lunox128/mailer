defmodule Jinx.Friends.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friends" do

    field :user_id, :id
    field :current_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(friend, attrs) do
    friend
    |> cast(attrs, [])
    |> validate_required([])
  end
end
