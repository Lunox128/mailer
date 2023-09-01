defmodule Jinx.VotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Votes` context.
  """

  @doc """
  Generate a vote.
  """
  def vote_fixture(attrs \\ %{}) do
    {:ok, vote} =
      attrs
      |> Enum.into(%{
        value: 42
      })
      |> Jinx.Votes.create_vote()

    vote
  end
end
