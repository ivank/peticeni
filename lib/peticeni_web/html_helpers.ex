defmodule PeticeniWeb.HtmlHelpers do
  @spec currency(number | Decimal.t()) :: binary
  def currency(value) do
    Number.Currency.number_to_currency(value, format: "%n%u", unit: "лв")
  end
end
