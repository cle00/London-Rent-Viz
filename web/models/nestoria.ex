defmodule LdnRent.Nestoria do
  use LdnRent.Web, :model

  schema "nestoria" do
    field :bathroom_number, :integer
    field :bedroom_number, :integer
    field :car_spaces, :integer
    field :commission, :float
    field :construction_year, :integer
    field :datasource_name, :string
    field :floor, :float
    field :img_height, :integer
    field :img_url, :string
    field :img_width, :integer
    field :keywords, :string
    field :latitude, :float
    field :lister_name, :string
    field :lister_url, :string
    field :listing_type, :string
    field :location_accuracy, :integer
    field :longitude, :float
    field :price, :float
    field :price_currency, :string
    field :price_formatted, :string
    field :price_high, :float
    field :price_low, :float
    field :price_type, :string
    field :property_type, :string
    field :size, :float
    field :size_type, :string
    field :summary, :string
    field :thumb_height, :integer
    field :thumb_url, :string
    field :thumb_width, :integer
    field :title, :string
    field :updated_in_days, :integer
    field :updated_in_days_formatted, :string
    field :place_name, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @required_fields ~w(bathroom_number bedroom_number car_spaces
                    commission construction_year datasource_name
                    floor img_height img_url img_width keywords
                    latitude lister_name lister_url
                    listing_type location_accuracy longitude
                    price price_currency price_formatted
                    price_high price_low price_type property_type
                    size size_type summary thumb_height thumb_url
                    thumb_width title updated_in_days
                    updated_in_days_formatted place_name)
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
  end
end
