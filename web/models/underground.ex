defmodule LdnRent.Underground do
  use LdnRent.Web, :model

  schema "underground" do
    field :station_name, :string
    field :display_name, :string
    field :lines, :string
    field :lines_id, :integer
    field :station_name_slug, :string
    field :latitude, :float
    field :longitude, :float
    field :zone, :float
    field :total_lines, :integer
    field :rail, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(station_name display_name latitude
                      longitude zone total_lines rail lines_id)
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> slugify_station_name()
  end

  defp slugify_station_name(changeset) do
    if station_name = get_change(changeset, :station_name) do
      put_change(changeset, :station_name_slug, slugify(station_name))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
