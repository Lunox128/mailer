defmodule Jinx.Emotes do
  @moduledoc """
  The Emotes context.
  """

  import Ecto.Query, warn: false
  alias Jinx.Repo

  alias Jinx.Emotes.Emote

  @doc """
  Returns the list of emotes.

  ## Examples

      iex> list_emotes()
      [%Emote{}, ...]

  """
  def list_emotes do
    Repo.all(Emote)
  end

  @doc """
  Gets a single emote.

  Raises `Ecto.NoResultsError` if the Emote does not exist.

  ## Examples

      iex> get_emote!(123)
      %Emote{}

      iex> get_emote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_emote!(id), do: Repo.get!(Emote, id)

  @doc """
  Creates a emote.

  ## Examples

      iex> create_emote(%{field: value})
      {:ok, %Emote{}}

      iex> create_emote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_emote(attrs \\ %{}) do
    %Emote{}
    |> Emote.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a emote.

  ## Examples

      iex> update_emote(emote, %{field: new_value})
      {:ok, %Emote{}}

      iex> update_emote(emote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_emote(%Emote{} = emote, attrs) do
    emote
    |> Emote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a emote.

  ## Examples

      iex> delete_emote(emote)
      {:ok, %Emote{}}

      iex> delete_emote(emote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_emote(%Emote{} = emote) do
    Repo.delete(emote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking emote changes.

  ## Examples

      iex> change_emote(emote)
      %Ecto.Changeset{data: %Emote{}}

  """
  def change_emote(%Emote{} = emote, attrs \\ %{}) do
    Emote.changeset(emote, attrs)
  end
end
