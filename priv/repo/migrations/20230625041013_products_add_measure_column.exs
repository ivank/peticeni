defmodule Peticeni.Repo.Migrations.PricesAddMeasureColumn do
  use Ecto.Migration

  @type_name :product_measure
  @values [:count, :liter, :kg]

  def change do
    execute(
      "CREATE TYPE #{@type_name} AS ENUM (#{Peticeni.Sql.to_sql_list(@values)})",
      "DROP TYPE #{@type_name}"
    )

    alter table(:products) do
      add :measure, @type_name, null: false, default: @values |> List.first() |> to_string
    end
  end
end
