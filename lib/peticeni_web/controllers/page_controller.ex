defmodule PeticeniWeb.PageController do
  use PeticeniWeb, :controller
  require Logger
  # alias Contex.{Dataset, LinePlot}

  def home(conn, _params) do
    # product_prices = Peticeni.Catalog.list_price_chart()
    products = Peticeni.Catalog.latest_products_with_trends()

    # Logger.debug("day_prices: #{inspect(day_prices)}")
    # Logger.debug("product_names: #{inspect(product_names)}")

    # data2 = Dataset.new(day_prices)
    # chart = LinePlot.new(data2, mapping: %{x_col: :date, y_cols: product_names})

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      products: products
    )
  end
end
