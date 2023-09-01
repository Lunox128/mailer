defmodule Jinx.Post_Tags do
  @moduledoc """
  The Post_Tags context.
  """

  import Ecto.Query, warn: false
  alias Jinx.Repo

  alias Jinx.Post_Tags.Post_Tag

  @doc """
  Returns the list of post_tags.

  ## Examples

      iex> list_post_tags()
      [%Post_Tag{}, ...]

  """
  def list_post_tags do
    Repo.all(Post_Tag)
  end

  @doc """
  Gets a single post__tag.

  Raises `Ecto.NoResultsError` if the Post  tag does not exist.

  ## Examples

      iex> get_post__tag!(123)
      %Post_Tag{}

      iex> get_post__tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post__tag!(id), do: Repo.get!(Post_Tag, id)

  @doc """
  Creates a post__tag.

  ## Examples

      iex> create_post__tag(%{field: value})
      {:ok, %Post_Tag{}}

      iex> create_post__tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post__tag(attrs \\ %{}) do
    %Post_Tag{}
    |> Post_Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post__tag.

  ## Examples

      iex> update_post__tag(post__tag, %{field: new_value})
      {:ok, %Post_Tag{}}

      iex> update_post__tag(post__tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post__tag(%Post_Tag{} = post__tag, attrs) do
    post__tag
    |> Post_Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post__tag.

  ## Examples

      iex> delete_post__tag(post__tag)
      {:ok, %Post_Tag{}}

      iex> delete_post__tag(post__tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post__tag(%Post_Tag{} = post__tag) do
    Repo.delete(post__tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post__tag changes.

  ## Examples

      iex> change_post__tag(post__tag)
      %Ecto.Changeset{data: %Post_Tag{}}

  """
  def change_post__tag(%Post_Tag{} = post__tag, attrs \\ %{}) do
    Post_Tag.changeset(post__tag, attrs)
  end
end
