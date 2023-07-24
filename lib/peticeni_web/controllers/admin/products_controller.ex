defmodule PeticeniWeb.Admin.ProductsController do
  use PeticeniWeb, :controller
  alias Peticeni.Catalog

  def index(conn, _params) do
    render(conn, :index, products: Catalog.list_products())
  end

  def new(conn, _params) do
    render(conn, :create, changeset: Catalog.change_product(%Catalog.Product{}))
  end

  def edit(conn, %{"id" => id}) do
    render(conn, :edit, changeset: id |> Catalog.get_product!() |> Catalog.change_product())
  end

  def create(conn, %{"product" => product}) do
    case Catalog.create_product(product) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/admin/products/#{item}/edit")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :create, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "product" => product}) do
    case id |> Catalog.get_product!() |> Catalog.update_product(product) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/admin/products/#{product}/edit")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end
