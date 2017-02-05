defmodule LdnRent.Repo.Migrations.TubeLines do
  use Ecto.Migration

  def change do
    create table(:underground) do
      add :station_name, :string
      add :lines, :string
      add :station_name_slug, :string
    end
  end
end
