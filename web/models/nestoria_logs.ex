defmodule LdnRent.NestoriaLogs do
  use LdnRent.Web, :model

  schema "nestoria_logs" do
    field :log, :string

    timestamps
  end
end
