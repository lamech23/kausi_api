defmodule KausiApiWeb.DetailsJSON do
  alias KausiApi.Details.Detail

  @doc """
  Renders a list of details.
  """
  def index(%{details: details}) do
    %{data: for(detail <- details, do: data(detail))}
  end

  @doc """
  Renders a single detail.
  """
  def show(%{detail: detail}) do
    %{data: data(detail)}
  end

  defp data(%Detail{} = detail) do
    %{
      id: detail.id,
      image: detail.image,
      title: detail.title,
      location: detail.location,
      description: detail.description,
      contact: detail.contact,
      price: detail.price,
      category: detail.category
    }
  end
end
