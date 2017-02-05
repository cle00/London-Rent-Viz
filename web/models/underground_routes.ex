defmodule LdnRent.UndergroundRoutes do
  use LdnRent.Web, :model

  schema "underground_routes" do
    field :line, :integer
    field :name, :string
    field :colour, :string
    field :stripe, :string

  end

  @doc """
    Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(line name colour stripe)
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
  end
end
