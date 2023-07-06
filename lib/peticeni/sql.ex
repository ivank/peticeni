defmodule Peticeni.Sql do
  @doc """
  Convert a list to a sql string of the list's items, expressed as strings.

  ## Examples

      iex> to_sql_list([:one, :two, :three])
      'one', 'two', 'three'

  """
  @spec to_sql_list([any]) :: String.t()
  def to_sql_list(list) do
    list |> Enum.map(&"'#{&1}'") |> Enum.join(", ")
  end
end
