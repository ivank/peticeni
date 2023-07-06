defmodule Peticeni.Catalog.Store do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stores" do
    field :name, :string

    has_many :prices, Peticeni.Catalog.Price
    many_to_many :products, Peticeni.Catalog.Product, join_through: Peticeni.Catalog.Price

    timestamps()
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
