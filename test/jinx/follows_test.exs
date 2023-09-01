defmodule Jinx.FollowsTest do
  use Jinx.DataCase

  alias Jinx.Follows

  describe "follows" do
    alias Jinx.Follows.Follow

    import Jinx.FollowsFixtures

    @invalid_attrs %{}

    test "list_follows/0 returns all follows" do
      follow = follow_fixture()
      assert Follows.list_follows() == [follow]
    end

    test "get_follow!/1 returns the follow with given id" do
      follow = follow_fixture()
      assert Follows.get_follow!(follow.id) == follow
    end

    test "create_follow/1 with valid data creates a follow" do
      valid_attrs = %{}

      assert {:ok, %Follow{} = follow} = Follows.create_follow(valid_attrs)
    end

    test "create_follow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Follows.create_follow(@invalid_attrs)
    end

    test "update_follow/2 with valid data updates the follow" do
      follow = follow_fixture()
      update_attrs = %{}

      assert {:ok, %Follow{} = follow} = Follows.update_follow(follow, update_attrs)
    end

    test "update_follow/2 with invalid data returns error changeset" do
      follow = follow_fixture()
      assert {:error, %Ecto.Changeset{}} = Follows.update_follow(follow, @invalid_attrs)
      assert follow == Follows.get_follow!(follow.id)
    end

    test "delete_follow/1 deletes the follow" do
      follow = follow_fixture()
      assert {:ok, %Follow{}} = Follows.delete_follow(follow)
      assert_raise Ecto.NoResultsError, fn -> Follows.get_follow!(follow.id) end
    end

    test "change_follow/1 returns a follow changeset" do
      follow = follow_fixture()
      assert %Ecto.Changeset{} = Follows.change_follow(follow)
    end
  end
end
