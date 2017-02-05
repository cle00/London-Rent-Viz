defmodule LdnRent.Repo.Migrations.UndergroundRoutes do
  use Ecto.Migration

  def change do
    create table(:underground_routes) do
      add :line, :integer
      add :name, :string
      add :colour, :string
      add :stripe, :string
    end
  end
end
