defmodule Jinx.User_Notifications do
  @moduledoc """
  The User_Notifications context.
  """

  import Ecto.Query, warn: false
  alias Jinx.Repo

  alias Jinx.User_Notifications.User_Notification

  @doc """
  Returns the list of user_notification.

  ## Examples

      iex> list_user_notification()
      [%User_Notification{}, ...]

  """
  def list_user_notification do
    Repo.all(User_Notification)
  end

  @doc """
  Gets a single user__notification.

  Raises `Ecto.NoResultsError` if the User  notification does not exist.

  ## Examples

      iex> get_user__notification!(123)
      %User_Notification{}

      iex> get_user__notification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user__notification!(id), do: Repo.get!(User_Notification, id)

  @doc """
  Creates a user__notification.

  ## Examples

      iex> create_user__notification(%{field: value})
      {:ok, %User_Notification{}}

      iex> create_user__notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user__notification(attrs \\ %{}) do
    %User_Notification{}
    |> User_Notification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user__notification.

  ## Examples

      iex> update_user__notification(user__notification, %{field: new_value})
      {:ok, %User_Notification{}}

      iex> update_user__notification(user__notification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user__notification(%User_Notification{} = user__notification, attrs) do
    user__notification
    |> User_Notification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user__notification.

  ## Examples

      iex> delete_user__notification(user__notification)
      {:ok, %User_Notification{}}

      iex> delete_user__notification(user__notification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user__notification(%User_Notification{} = user__notification) do
    Repo.delete(user__notification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user__notification changes.

  ## Examples

      iex> change_user__notification(user__notification)
      %Ecto.Changeset{data: %User_Notification{}}

  """
  def change_user__notification(%User_Notification{} = user__notification, attrs \\ %{}) do
    User_Notification.changeset(user__notification, attrs)
  end
end
