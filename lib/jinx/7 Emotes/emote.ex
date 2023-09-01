defmodule Jinx.Emotes.Emote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emotes" do
    field :read, :boolean, default: false
    field :type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(emote, attrs) do
    emote
    |> cast(attrs, [:type, :read])
    |> validate_required([:type, :read])
  end
end
