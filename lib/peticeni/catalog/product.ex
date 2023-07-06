defmodule Peticeni.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field(:measure, Ecto.Enum, values: [:count, :liter, :kg], default: :count)

    has_many :prices, Peticeni.Catalog.Price

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
