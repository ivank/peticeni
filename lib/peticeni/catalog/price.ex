defmodule Peticeni.Catalog.Price do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  @type t :: %__MODULE__{
          date: NativeDate.t(),
          price: integer(),
          store: Store.t(),
          store_id: integer(),
          product: Product.t(),
          product_id: integer(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "prices" do
    field(:date, :date)
    field(:price, :integer)

    belongs_to(:product, Peticeni.Catalog.Product)
    belongs_to(:store, Peticeni.Catalog.Store)

    timestamps()
    soft_delete_schema()
  end

  @doc false
  def changeset(price, attrs) do
    price
    |> cast(attrs, [:product_id, :store_id, :price, :date])
    |> foreign_key_constraint(:product_id)
    |> foreign_key_constraint(:store_id)
    |> validate_required([:product_id, :store_id, :price, :date])
  end
end
