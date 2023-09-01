defmodule Jinx.RequestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jinx.Requests` context.
  """

  @doc """
  Generate a request.
  """
  def request_fixture(attrs \\ %{}) do
    {:ok, request} =
      attrs
      |> Enum.into(%{

      })
      |> Jinx.Requests.create_request()

    request
  end
end
