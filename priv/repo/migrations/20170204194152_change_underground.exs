defmodule LdnRent.Repo.Migrations.ChangeUnderground do
  use Ecto.Migration

  def change do
    alter table(:underground) do
      add :lines_id, :integer
    end
  end
end
