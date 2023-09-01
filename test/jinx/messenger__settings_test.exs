defmodule Jinx.Messenger_SettingsTest do
  use Jinx.DataCase

  alias Jinx.Messenger_Settings

  describe "messenger_settings" do
    alias Jinx.Messenger_Settings.Messenger_Setting

    import Jinx.Messenger_SettingsFixtures

    @invalid_attrs %{read: nil, type: nil}

    test "list_messenger_settings/0 returns all messenger_settings" do
      messenger__setting = messenger__setting_fixture()
      assert Messenger_Settings.list_messenger_settings() == [messenger__setting]
    end

    test "get_messenger__setting!/1 returns the messenger__setting with given id" do
      messenger__setting = messenger__setting_fixture()
      assert Messenger_Settings.get_messenger__setting!(messenger__setting.id) == messenger__setting
    end

    test "create_messenger__setting/1 with valid data creates a messenger__setting" do
      valid_attrs = %{read: true, type: "some type"}

      assert {:ok, %Messenger_Setting{} = messenger__setting} = Messenger_Settings.create_messenger__setting(valid_attrs)
      assert messenger__setting.read == true
      assert messenger__setting.type == "some type"
    end

    test "create_messenger__setting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messenger_Settings.create_messenger__setting(@invalid_attrs)
    end

    test "update_messenger__setting/2 with valid data updates the messenger__setting" do
      messenger__setting = messenger__setting_fixture()
      update_attrs = %{read: false, type: "some updated type"}

      assert {:ok, %Messenger_Setting{} = messenger__setting} = Messenger_Settings.update_messenger__setting(messenger__setting, update_attrs)
      assert messenger__setting.read == false
      assert messenger__setting.type == "some updated type"
    end

    test "update_messenger__setting/2 with invalid data returns error changeset" do
      messenger__setting = messenger__setting_fixture()
      assert {:error, %Ecto.Changeset{}} = Messenger_Settings.update_messenger__setting(messenger__setting, @invalid_attrs)
      assert messenger__setting == Messenger_Settings.get_messenger__setting!(messenger__setting.id)
    end

    test "delete_messenger__setting/1 deletes the messenger__setting" do
      messenger__setting = messenger__setting_fixture()
      assert {:ok, %Messenger_Setting{}} = Messenger_Settings.delete_messenger__setting(messenger__setting)
      assert_raise Ecto.NoResultsError, fn -> Messenger_Settings.get_messenger__setting!(messenger__setting.id) end
    end

    test "change_messenger__setting/1 returns a messenger__setting changeset" do
      messenger__setting = messenger__setting_fixture()
      assert %Ecto.Changeset{} = Messenger_Settings.change_messenger__setting(messenger__setting)
    end
  end
end
