defmodule Jinx.BlocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Blocks` context.
  """

  @doc """
  Generate a block.
  """
  def block_fixture(attrs \\ %{}) do
    {:ok, block} =
      attrs
      |> Enum.into(%{
        status: "some status"
      })
      |> Jinx.Blocks.create_block()

    block
  end
end
