defmodule Jinx.FollowsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Follows` context.
  """

  @doc """
  Generate a follow.
  """
  def follow_fixture(attrs \\ %{}) do
    {:ok, follow} =
      attrs
      |> Enum.into(%{

      })
      |> Jinx.Follows.create_follow()

    follow
  end
end
