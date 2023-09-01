defmodule Jinx.EmotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Emotes` context.
  """

  @doc """
  Generate a emote.
  """
  def emote_fixture(attrs \\ %{}) do
    {:ok, emote} =
      attrs
      |> Enum.into(%{
        read: true,
        type: "some type"
      })
      |> Jinx.Emotes.create_emote()

    emote
  end
end
