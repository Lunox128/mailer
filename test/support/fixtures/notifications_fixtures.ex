defmodule Jinx.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Notifications` context.
  """

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        read: true,
        type: "some type"
      })
      |> Jinx.Notifications.create_notification()

    notification
  end
end
