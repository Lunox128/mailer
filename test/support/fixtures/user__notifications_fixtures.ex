defmodule Jinx.User_NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.User_Notifications` context.
  """

  @doc """
  Generate a user__notification.
  """
  def user__notification_fixture(attrs \\ %{}) do
    {:ok, user__notification} =
      attrs
      |> Enum.into(%{
        read: true,
        type: "some type"
      })
      |> Jinx.User_Notifications.create_user__notification()

    user__notification
  end
end
