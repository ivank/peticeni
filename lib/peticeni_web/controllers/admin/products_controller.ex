defmodule PeticeniWeb.Admin.ProductsController do
  use PeticeniWeb, :controller
  alias Peticeni.Catalog

  def index(conn, _params) do
    render(conn, :index, products: Catalog.list_products())
  end

  def edit(conn, %{"id" => id}) do
    render(conn, :edit, changeset: id |> Catalog.get_product!() |> Catalog.change_product())
  end

  def update(conn, %{"id" => id, "product" => params}) do
    case id |> Catalog.get_product!() |> Catalog.update_product(params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/admin/products/#{product}/edit")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end
