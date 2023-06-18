defmodule KausiApi.Repo.Migrations.CreateDetails do
  use Ecto.Migration

  def change do
    create table(:details, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :image, :string
      add :title, :string
      add :location, :string
      add :description, :string
      add :contact, :string
      add :price, :float
      add :category, :string

      timestamps()
    end
  end
end
