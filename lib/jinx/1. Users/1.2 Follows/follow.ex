defmodule Jinx.Follows.Follow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "follows" do

    field :user_id, :id
    field :current_user_id, :id
    field :board_id, :id

    timestamps()
  end

  @doc false
  def changeset(follow, attrs) do
    follow
    |> cast(attrs, [])
    |> validate_required([])
  end
end
