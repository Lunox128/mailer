defmodule Jinx.Post_TagsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Post_Tags` context.
  """

  @doc """
  Generate a post__tag.
  """
  def post__tag_fixture(attrs \\ %{}) do
    {:ok, post__tag} =
      attrs
      |> Enum.into(%{

      })
      |> Jinx.Post_Tags.create_post__tag()

    post__tag
  end
end
