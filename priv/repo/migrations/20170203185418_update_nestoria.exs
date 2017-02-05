defmodule LdnRent.Repo.Migrations.UpdateNestoria do
  use Ecto.Migration

  def change do
    alter table(:nestoria) do
      add :place_name, :text
    end
  end
end
