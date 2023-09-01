defmodule Jinx.Votes.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :value, :integer
    field :user_id, :id
    field :post_id, :id
    field :comment_id, :id

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
