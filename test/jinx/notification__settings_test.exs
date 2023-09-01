defmodule Jinx.Notification_SettingsTest do
  use Jinx.DataCase

  alias Jinx.Notification_Settings

  describe "notification_settings" do
    alias Jinx.Notification_Settings.Notification_Setting

    import Jinx.Notification_SettingsFixtures

    @invalid_attrs %{read: nil, type: nil}

    test "list_notification_settings/0 returns all notification_settings" do
      notification__setting = notification__setting_fixture()
      assert Notification_Settings.list_notification_settings() == [notification__setting]
    end

    test "get_notification__setting!/1 returns the notification__setting with given id" do
      notification__setting = notification__setting_fixture()
      assert Notification_Settings.get_notification__setting!(notification__setting.id) == notification__setting
    end

    test "create_notification__setting/1 with valid data creates a notification__setting" do
      valid_attrs = %{read: true, type: "some type"}

      assert {:ok, %Notification_Setting{} = notification__setting} = Notification_Settings.create_notification__setting(valid_attrs)
      assert notification__setting.read == true
      assert notification__setting.type == "some type"
    end

    test "create_notification__setting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notification_Settings.create_notification__setting(@invalid_attrs)
    end

    test "update_notification__setting/2 with valid data updates the notification__setting" do
      notification__setting = notification__setting_fixture()
      update_attrs = %{read: false, type: "some updated type"}

      assert {:ok, %Notification_Setting{} = notification__setting} = Notification_Settings.update_notification__setting(notification__setting, update_attrs)
      assert notification__setting.read == false
      assert notification__setting.type == "some updated type"
    end

    test "update_notification__setting/2 with invalid data returns error changeset" do
      notification__setting = notification__setting_fixture()
      assert {:error, %Ecto.Changeset{}} = Notification_Settings.update_notification__setting(notification__setting, @invalid_attrs)
      assert notification__setting == Notification_Settings.get_notification__setting!(notification__setting.id)
    end

    test "delete_notification__setting/1 deletes the notification__setting" do
      notification__setting = notification__setting_fixture()
      assert {:ok, %Notification_Setting{}} = Notification_Settings.delete_notification__setting(notification__setting)
      assert_raise Ecto.NoResultsError, fn -> Notification_Settings.get_notification__setting!(notification__setting.id) end
    end

    test "change_notification__setting/1 returns a notification__setting changeset" do
      notification__setting = notification__setting_fixture()
      assert %Ecto.Changeset{} = Notification_Settings.change_notification__setting(notification__setting)
    end
  end
end
