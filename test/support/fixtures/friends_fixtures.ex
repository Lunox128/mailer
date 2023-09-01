defmodule Jinx.FriendsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Friends` context.
  """

  @doc """
  Generate a friend.
  """
  def friend_fixture(attrs \\ %{}) do
    {:ok, friend} =
      attrs
      |> Enum.into(%{

      })
      |> Jinx.Friends.create_friend()

    friend
  end
end
