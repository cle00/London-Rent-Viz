defmodule LdnRent.Repo.Migrations.UpdateUnderground do
  use Ecto.Migration

  def change do
    alter table(:underground) do
      add :display_name, :string
      add :latitude, :float
      add :longitude, :float
      add :zone, :float
      add :total_lines, :integer
      add :rail, :integer
    end
  end
end
