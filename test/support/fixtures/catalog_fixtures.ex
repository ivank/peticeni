defmodule Peticeni.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Peticeni.Catalog` context.
  """

  @doc """
  Generate a price.
  """
  def price_fixture(attrs \\ %{}) do
    store = store_fixture()
    product = product_fixture()

    {:ok, price} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-05-19],
        price: 42,
        product_id: product.id,
        store_id: store.id
      })
      |> Peticeni.Catalog.create_price()

    price
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Peticeni.Catalog.create_product()

    product
  end

  @doc """
  Generate a store.
  """
  def store_fixture(attrs \\ %{}) do
    {:ok, store} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Peticeni.Catalog.create_store()

    store
  end
end
