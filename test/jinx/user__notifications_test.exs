defmodule Jinx.User_NotificationsTest do
  use Jinx.DataCase

  alias Jinx.User_Notifications

  describe "user_notification" do
    alias Jinx.User_Notifications.User_Notification

    import Jinx.User_NotificationsFixtures

    @invalid_attrs %{read: nil, type: nil}

    test "list_user_notification/0 returns all user_notification" do
      user__notification = user__notification_fixture()
      assert User_Notifications.list_user_notification() == [user__notification]
    end

    test "get_user__notification!/1 returns the user__notification with given id" do
      user__notification = user__notification_fixture()
      assert User_Notifications.get_user__notification!(user__notification.id) == user__notification
    end

    test "create_user__notification/1 with valid data creates a user__notification" do
      valid_attrs = %{read: true, type: "some type"}

      assert {:ok, %User_Notification{} = user__notification} = User_Notifications.create_user__notification(valid_attrs)
      assert user__notification.read == true
      assert user__notification.type == "some type"
    end

    test "create_user__notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User_Notifications.create_user__notification(@invalid_attrs)
    end

    test "update_user__notification/2 with valid data updates the user__notification" do
      user__notification = user__notification_fixture()
      update_attrs = %{read: false, type: "some updated type"}

      assert {:ok, %User_Notification{} = user__notification} = User_Notifications.update_user__notification(user__notification, update_attrs)
      assert user__notification.read == false
      assert user__notification.type == "some updated type"
    end

    test "update_user__notification/2 with invalid data returns error changeset" do
      user__notification = user__notification_fixture()
      assert {:error, %Ecto.Changeset{}} = User_Notifications.update_user__notification(user__notification, @invalid_attrs)
      assert user__notification == User_Notifications.get_user__notification!(user__notification.id)
    end

    test "delete_user__notification/1 deletes the user__notification" do
      user__notification = user__notification_fixture()
      assert {:ok, %User_Notification{}} = User_Notifications.delete_user__notification(user__notification)
      assert_raise Ecto.NoResultsError, fn -> User_Notifications.get_user__notification!(user__notification.id) end
    end

    test "change_user__notification/1 returns a user__notification changeset" do
      user__notification = user__notification_fixture()
      assert %Ecto.Changeset{} = User_Notifications.change_user__notification(user__notification)
    end
  end
end
