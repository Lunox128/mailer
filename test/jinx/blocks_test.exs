defmodule Jinx.BlocksTest do
  use Jinx.DataCase

  alias Jinx.Blocks

  describe "blocks" do
    alias Jinx.Blocks.Block

    import Jinx.BlocksFixtures

    @invalid_attrs %{status: nil}

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert Blocks.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert Blocks.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      valid_attrs = %{status: "some status"}

      assert {:ok, %Block{} = block} = Blocks.create_block(valid_attrs)
      assert block.status == "some status"
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blocks.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      update_attrs = %{status: "some updated status"}

      assert {:ok, %Block{} = block} = Blocks.update_block(block, update_attrs)
      assert block.status == "some updated status"
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = Blocks.update_block(block, @invalid_attrs)
      assert block == Blocks.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = Blocks.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Blocks.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = Blocks.change_block(block)
    end
  end
end
