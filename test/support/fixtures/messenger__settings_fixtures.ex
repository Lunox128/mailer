defmodule Jinx.Messenger_SettingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Messenger_Settings` context.
  """

  @doc """
  Generate a messenger__setting.
  """
  def messenger__setting_fixture(attrs \\ %{}) do
    {:ok, messenger__setting} =
      attrs
      |> Enum.into(%{
        read: true,
        type: "some type"
      })
      |> Jinx.Messenger_Settings.create_messenger__setting()

    messenger__setting
  end
end
