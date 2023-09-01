defmodule Jinx.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do

    field :user_id, :id
    field :current_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [])
    |> validate_required([])
  end
end
