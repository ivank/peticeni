defmodule Peticeni.Catalog.Price do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prices" do
    field(:date, :date)
    field(:price, :integer)

    belongs_to(:product, Peticeni.Catalog.Product)
    belongs_to(:store, Peticeni.Catalog.Store)

    timestamps()
  end

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, [:product_id, :store_id, :price, :date])
    |> validate_required([:product_id, :store_id, :price, :date])
  end
end
