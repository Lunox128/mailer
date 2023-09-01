defmodule Jinx.Messenger_Settings do
  @moduledoc """
  The Messenger_Settings context.
  """

  import Ecto.Query, warn: false
  alias Jinx.Repo

  alias Jinx.Messenger_Settings.Messenger_Setting

  @doc """
  Returns the list of messenger_settings.

  ## Examples

      iex> list_messenger_settings()
      [%Messenger_Setting{}, ...]

  """
  def list_messenger_settings do
    Repo.all(Messenger_Setting)
  end

  @doc """
  Gets a single messenger__setting.

  Raises `Ecto.NoResultsError` if the Messenger  setting does not exist.

  ## Examples

      iex> get_messenger__setting!(123)
      %Messenger_Setting{}

      iex> get_messenger__setting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_messenger__setting!(id), do: Repo.get!(Messenger_Setting, id)

  @doc """
  Creates a messenger__setting.

  ## Examples

      iex> create_messenger__setting(%{field: value})
      {:ok, %Messenger_Setting{}}

      iex> create_messenger__setting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_messenger__setting(attrs \\ %{}) do
    %Messenger_Setting{}
    |> Messenger_Setting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a messenger__setting.

  ## Examples

      iex> update_messenger__setting(messenger__setting, %{field: new_value})
      {:ok, %Messenger_Setting{}}

      iex> update_messenger__setting(messenger__setting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_messenger__setting(%Messenger_Setting{} = messenger__setting, attrs) do
    messenger__setting
    |> Messenger_Setting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a messenger__setting.

  ## Examples

      iex> delete_messenger__setting(messenger__setting)
      {:ok, %Messenger_Setting{}}

      iex> delete_messenger__setting(messenger__setting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_messenger__setting(%Messenger_Setting{} = messenger__setting) do
    Repo.delete(messenger__setting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking messenger__setting changes.

  ## Examples

      iex> change_messenger__setting(messenger__setting)
      %Ecto.Changeset{data: %Messenger_Setting{}}

  """
  def change_messenger__setting(%Messenger_Setting{} = messenger__setting, attrs \\ %{}) do
    Messenger_Setting.changeset(messenger__setting, attrs)
  end
end
