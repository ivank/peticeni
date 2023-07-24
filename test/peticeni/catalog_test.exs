defmodule Peticeni.CatalogTest do
  use Peticeni.DataCase

  alias Peticeni.Catalog

  describe "prices" do
    alias Peticeni.Catalog.Price

    import Peticeni.CatalogFixtures

    @invalid_attrs %{date: nil, price: nil, product_id: nil, store_id: nil}

    test "list_prices/0 returns all prices" do
      price = price_fixture()
      assert Catalog.list_prices() == [price]
    end

    test "get_price!/1 returns the price with given id" do
      price = price_fixture()
      assert Catalog.get_price!(price.id) == price
    end

    test "create_price/1 with valid data creates a price" do
      store = store_fixture()
      product = product_fixture()

      valid_attrs = %{date: ~D[2023-05-19], price: 42, product_id: product.id, store_id: store.id}

      assert {:ok, %Price{} = price} = Catalog.create_price(valid_attrs)
      assert price.date == ~D[2023-05-19]
      assert price.price == 42
      assert price.product_id == product.id
      assert price.store_id == store.id
    end

    test "create_price/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_price(@invalid_attrs)
    end

    test "update_price/2 with valid data updates the price" do
      price = price_fixture()

      store2 = store_fixture()
      product2 = product_fixture()

      update_attrs = %{
        date: ~D[2023-05-20],
        price: 43,
        product_id: product2.id,
        store_id: store2.id
      }

      assert {:ok, %Price{} = price} = Catalog.update_price(price, update_attrs)
      assert price.date == ~D[2023-05-20]
      assert price.price == 43
      assert price.product_id == product2.id
      assert price.store_id == store2.id
    end

    test "update_price/2 with invalid data returns error changeset" do
      price = price_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_price(price, @invalid_attrs)
      assert price == Catalog.get_price!(price.id)
    end

    test "delete_price/1 deletes the price" do
      price = price_fixture()
      assert {:ok, %Price{}} = Catalog.delete_price(price)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_price!(price.id) end
    end

    test "change_price/1 returns a price changeset" do
      price = price_fixture()
      assert %Ecto.Changeset{} = Catalog.change_price(price)
    end
  end

  describe "products" do
    alias Peticeni.Catalog.Product

    import Peticeni.CatalogFixtures

    @invalid_attrs %{name: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.name == "some name"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.name == "some updated name"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  describe "stores" do
    alias Peticeni.Catalog.Store

    import Peticeni.CatalogFixtures

    @invalid_attrs %{name: nil}

    test "list_stores/0 returns all stores" do
      store = store_fixture()
      assert Catalog.list_stores() == [store]
    end

    test "get_store!/1 returns the store with given id" do
      store = store_fixture()
      assert Catalog.get_store!(store.id) == store
    end

    test "create_store/1 with valid data creates a store" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Store{} = store} = Catalog.create_store(valid_attrs)
      assert store.name == "some name"
    end

    test "create_store/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_store(@invalid_attrs)
    end

    test "update_store/2 with valid data updates the store" do
      store = store_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Store{} = store} = Catalog.update_store(store, update_attrs)
      assert store.name == "some updated name"
    end

    test "update_store/2 with invalid data returns error changeset" do
      store = store_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_store(store, @invalid_attrs)
      assert store == Catalog.get_store!(store.id)
    end

    test "delete_store/1 deletes the store" do
      store = store_fixture()
      assert {:ok, %Store{}} = Catalog.delete_store(store)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_store!(store.id) end
    end

    test "change_store/1 returns a store changeset" do
      store = store_fixture()
      assert %Ecto.Changeset{} = Catalog.change_store(store)
    end
  end
end
