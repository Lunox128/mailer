defmodule Jinx.Post_Tags.Post_Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_tags" do

    field :tag_id, :id
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(post__tag, attrs) do
    post__tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
