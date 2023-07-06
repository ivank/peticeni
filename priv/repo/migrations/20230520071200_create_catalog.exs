defmodule Peticeni.Repo.Migrations.CreatePrices do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string

      timestamps()
    end

    create table(:stores) do
      add :name, :string

      timestamps()
    end

    create table(:prices) do
      add :product_id, references(:products)
      add :store_id, references(:stores)
      add :price, :integer
      add :date, :date

      timestamps()
    end
  end
end
