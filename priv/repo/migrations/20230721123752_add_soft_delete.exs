defmodule Peticeni.Repo.Migrations.AddSoftDelete do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    alter table(:products) do
      soft_delete_columns()
    end

    alter table(:prices) do
      soft_delete_columns()
    end

    alter table(:stores) do
      soft_delete_columns()
    end
  end
end
