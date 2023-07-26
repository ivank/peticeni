defmodule PeticeniWeb.HtmlHelpers do
  @spec currency(number | Decimal.t()) :: binary
  def currency(value) do
    Number.Currency.number_to_currency(value, format: "%n%u", unit: "лв")
  end

  @doc """
  Puts a `value` under `key` only if the value is not `nil`, `[]` or `%{}`.

  If a `:default` value is passed, it only puts the value into the list if the
  value does not match the default value.

      iex> maybe_put([], :a, "b")
      [a: "b"]

      iex> maybe_put([], :a, nil)
      []

      iex> maybe_put([], :a, [])
      []

      iex> maybe_put([], :a, %{})
      []

      iex> maybe_put([], :a, "a", "a")
      []

      iex> maybe_put([], :a, "a", "b")
      [a: "a"]
  """
  @spec maybe_put(keyword, atom, any, any) :: keyword
  def maybe_put(params, key, value, default \\ nil)
  def maybe_put(keywords, _, nil, _), do: keywords
  def maybe_put(keywords, _, [], _), do: keywords
  def maybe_put(keywords, _, map, _) when map == %{}, do: keywords
  def maybe_put(keywords, _, val, val), do: keywords
  def maybe_put(keywords, key, value, _), do: Keyword.put_new(keywords, key, value)

  def flop_query(%Flop.Meta{flop: flop, opts: opts}, initial) do
    filter_map =
      flop.filters
      |> Stream.with_index()
      |> Enum.into(%{}, fn {filter, index} ->
        {index, Map.from_struct(filter)}
      end)

    default_limit = Flop.get_option(:default_limit, opts)

    # {order_by: default_order_by, order_directions: default_order_directions} = Flop.get_option(:default_order, opts)

    initial
    |> maybe_put(:offset, flop.offset, 0)
    |> maybe_put(:page, flop.page, 1)
    |> maybe_put(:after, flop.after)
    |> maybe_put(:before, flop.before)
    |> maybe_put(:page_size, flop.page_size, default_limit)
    |> maybe_put(:limit, flop.limit, default_limit)
    |> maybe_put(:first, flop.first, default_limit)
    |> maybe_put(:last, flop.last, default_limit)
    # |> maybe_put(:order_by, flop.order_by, default_order_by)
    # |> maybe_put(:order_directions, flop.order_directions, default_order_directions)
    |> maybe_put(:filters, filter_map)
  end
end
