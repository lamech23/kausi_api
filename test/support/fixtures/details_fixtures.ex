defmodule KausiApi.DetailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KausiApi.Details` context.
  """

  @doc """
  Generate a detail.
  """
  def detail_fixture(attrs \\ %{}) do
    {:ok, detail} =
      attrs
      |> Enum.into(%{
        category: "some category",
        contact: "some contact",
        description: "some description",
        image: "some image",
        location: "some location",
        price: 120.5,
        title: "some title"
      })
      |> KausiApi.Details.create_detail()

    detail
  end
end
