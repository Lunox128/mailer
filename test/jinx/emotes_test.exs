defmodule Jinx.EmotesTest do
  use Jinx.DataCase

  alias Jinx.Emotes

  describe "emotes" do
    alias Jinx.Emotes.Emote

    import Jinx.EmotesFixtures

    @invalid_attrs %{read: nil, type: nil}

    test "list_emotes/0 returns all emotes" do
      emote = emote_fixture()
      assert Emotes.list_emotes() == [emote]
    end

    test "get_emote!/1 returns the emote with given id" do
      emote = emote_fixture()
      assert Emotes.get_emote!(emote.id) == emote
    end

    test "create_emote/1 with valid data creates a emote" do
      valid_attrs = %{read: true, type: "some type"}

      assert {:ok, %Emote{} = emote} = Emotes.create_emote(valid_attrs)
      assert emote.read == true
      assert emote.type == "some type"
    end

    test "create_emote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Emotes.create_emote(@invalid_attrs)
    end

    test "update_emote/2 with valid data updates the emote" do
      emote = emote_fixture()
      update_attrs = %{read: false, type: "some updated type"}

      assert {:ok, %Emote{} = emote} = Emotes.update_emote(emote, update_attrs)
      assert emote.read == false
      assert emote.type == "some updated type"
    end

    test "update_emote/2 with invalid data returns error changeset" do
      emote = emote_fixture()
      assert {:error, %Ecto.Changeset{}} = Emotes.update_emote(emote, @invalid_attrs)
      assert emote == Emotes.get_emote!(emote.id)
    end

    test "delete_emote/1 deletes the emote" do
      emote = emote_fixture()
      assert {:ok, %Emote{}} = Emotes.delete_emote(emote)
      assert_raise Ecto.NoResultsError, fn -> Emotes.get_emote!(emote.id) end
    end

    test "change_emote/1 returns a emote changeset" do
      emote = emote_fixture()
      assert %Ecto.Changeset{} = Emotes.change_emote(emote)
    end
  end
end
