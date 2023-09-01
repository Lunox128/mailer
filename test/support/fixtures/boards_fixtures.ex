defmodule Jinx.BoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Boards` context.
  """

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Jinx.Boards.create_board()

    board
  end
end
