defmodule Jinx.Blocks.Block do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blocks" do
    field :status, :string
    field :user_id, :id
    field :current_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
