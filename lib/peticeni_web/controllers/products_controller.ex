defmodule PeticeniWeb.ProductsController do
  use PeticeniWeb, :controller
  alias Contex.{Plot, Dataset, LinePlot, ContinuousLinearScale}
  alias Peticeni.Catalog
  require Logger

  def index(conn, _params) do
    products = Catalog.latest_products_with_trends()

    render(conn, :index, products: products)
  end

  @type product_price :: %{price: number, store: String.t(), date: Date.t()}
  @type plot_day_prices :: %{String.t() => number, date: Date.t()}
  @spec prices_to_plot_data([product_price]) :: {[String.t()], number, [plot_day_prices]}
  defp prices_to_plot_data(prices) do
    # Group by date and merge all the prices from different stores into one map, expected by Context.LinePlot
    prices_grouped_by_date =
      Enum.group_by(prices, & &1.date)
      |> Map.to_list()
      |> Enum.map(fn {date, prices} ->
        Map.merge(
          %{date: DateTime.new!(date, ~T[00:00:00])},
          Enum.reduce(prices, %{}, &Map.put(&2, &1.store, &1.price))
        )
      end)

    # Get a unique list of all the store names
    store_names = Enum.reduce(prices, MapSet.new(), &MapSet.put(&2, &1.store)) |> MapSet.to_list()

    # Maximum of all prices for this product, used to set the y-axis scale
    max_price = Enum.reduce(prices, 0, &max(&2, &1.price))

    # Fill in missing prices for each store, so that each store has a price for each date,
    # and if its nil, fill it with the previous date's price
    filled_in_prices =
      Enum.map(prices_grouped_by_date, fn day_prices ->
        Enum.reduce(store_names, day_prices, fn store_name, day_prices ->
          Map.put_new(
            day_prices,
            store_name,
            Enum.find_value(prices_grouped_by_date, &Map.get(&1, store_name))
          )
        end)
      end)

    {store_names, max_price, filled_in_prices}
  end

  def show(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    prices = Catalog.product_prices(product.id)

    {store_names, max_price, data} = prices_to_plot_data(prices)

    plot =
      Plot.new(Dataset.new(data), LinePlot, 700, 400,
        mapping: %{x_col: :date, y_cols: store_names},
        legend_setting: :legend_right,
        smoothed: false,
        custom_y_formatter: &PeticeniWeb.HtmlHelpers.currency/1,
        custom_y_scale: ContinuousLinearScale.new() |> ContinuousLinearScale.domain(0, max_price)
      )

    render(conn, :show, product: product, prices: prices, plot: plot)
  end
end
