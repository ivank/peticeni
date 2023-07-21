defmodule Peticeni.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          name: String.t(),
          measure: :count | :liter | :kg,
          prices: [Price.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "products" do
    field :name, :string
    field(:measure, Ecto.Enum, values: [:count, :liter, :kg], default: :count)

    has_many :prices, Peticeni.Catalog.Price
    many_to_many :stores, Peticeni.Catalog.Store, join_through: Peticeni.Catalog.Price

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :measure])
    |> validate_required([:name, :measure])
  end
end
