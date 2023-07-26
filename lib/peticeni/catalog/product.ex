defmodule Peticeni.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  @type t :: %__MODULE__{
          name: String.t(),
          measure: :count | :liter | :kg,
          prices: [Price.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @derive {
    Flop.Schema,
    filterable: [:name, :measure, :store],
    sortable: [:name, :measure, :store],
    adapter_opts: [
      join_fields: [
        store: [binding: :prices, field: :store_id, ecto_type: :integer]
      ]
    ],
    default_limit: 5
  }

  schema "products" do
    field(:name, :string)
    field(:measure, Ecto.Enum, values: [:count, :liter, :kg], default: :count)

    has_many(:prices, Peticeni.Catalog.Price)
    many_to_many(:stores, Peticeni.Catalog.Store, join_through: Peticeni.Catalog.Price)

    timestamps()
    soft_delete_schema()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :measure])
    |> validate_required([:name, :measure])
  end
end
