defmodule LdnRent.Repo.Migrations.NestoriaLog do
  use Ecto.Migration

  def change do
    create table(:nestoria_logs) do
      add :log, :string
      timestamps
    end
  end
end
