defmodule KausiApi.Details.Detail do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "details" do
    field :category, :string
    field :contact, :string
    field :description, :string
    field :image, KausiApi.ImageUploader.Type
    field :location, :string
    field :price, :float
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(detail, attrs) do
    detail
    |> cast(attrs, [:image, :title, :location, :description, :contact, :price, :category])
    |> validate_required([:image, :title, :location, :description, :contact, :price, :category])
    # |> validate_format(:image, ~r/\.(png|jpg|gif)$/i, message: "must be a valid image file")
    |> validate_length(:description, min: 10, message: "must be at least 10 characters long")
  end
end
