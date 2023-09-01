defmodule Jinx.Notification_Settings do
  @moduledoc """
  The Notification_Settings context.
  """

  import Ecto.Query, warn: false
  alias Jinx.Repo

  alias Jinx.Notification_Settings.Notification_Setting

  @doc """
  Returns the list of notification_settings.

  ## Examples

      iex> list_notification_settings()
      [%Notification_Setting{}, ...]

  """
  def list_notification_settings do
    Repo.all(Notification_Setting)
  end

  @doc """
  Gets a single notification__setting.

  Raises `Ecto.NoResultsError` if the Notification  setting does not exist.

  ## Examples

      iex> get_notification__setting!(123)
      %Notification_Setting{}

      iex> get_notification__setting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notification__setting!(id), do: Repo.get!(Notification_Setting, id)

  @doc """
  Creates a notification__setting.

  ## Examples

      iex> create_notification__setting(%{field: value})
      {:ok, %Notification_Setting{}}

      iex> create_notification__setting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notification__setting(attrs \\ %{}) do
    %Notification_Setting{}
    |> Notification_Setting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a notification__setting.

  ## Examples

      iex> update_notification__setting(notification__setting, %{field: new_value})
      {:ok, %Notification_Setting{}}

      iex> update_notification__setting(notification__setting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notification__setting(%Notification_Setting{} = notification__setting, attrs) do
    notification__setting
    |> Notification_Setting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a notification__setting.

  ## Examples

      iex> delete_notification__setting(notification__setting)
      {:ok, %Notification_Setting{}}

      iex> delete_notification__setting(notification__setting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notification__setting(%Notification_Setting{} = notification__setting) do
    Repo.delete(notification__setting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notification__setting changes.

  ## Examples

      iex> change_notification__setting(notification__setting)
      %Ecto.Changeset{data: %Notification_Setting{}}

  """
  def change_notification__setting(%Notification_Setting{} = notification__setting, attrs \\ %{}) do
    Notification_Setting.changeset(notification__setting, attrs)
  end
end
