defmodule HelloHtmx.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloHtmx.Content` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        author: "some author",
        body: "some body",
        title: "some title"
      })
      |> HelloHtmx.Content.create_post()

    post
  end
end
