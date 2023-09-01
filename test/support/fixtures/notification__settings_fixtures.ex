defmodule Jinx.Notification_SettingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Notification_Settings` context.
  """

  @doc """
  Generate a notification__setting.
  """
  def notification__setting_fixture(attrs \\ %{}) do
    {:ok, notification__setting} =
      attrs
      |> Enum.into(%{
        read: true,
        type: "some type"
      })
      |> Jinx.Notification_Settings.create_notification__setting()

    notification__setting
  end
end
