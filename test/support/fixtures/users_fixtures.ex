defmodule KausiApi.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KausiApi.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> KausiApi.Users.create_user()

    user
  end
end
