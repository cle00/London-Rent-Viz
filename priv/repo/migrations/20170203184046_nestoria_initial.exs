defmodule LdnRent.Repo.Migrations.NestoriaInitial do
  use Ecto.Migration

  def change do
    create table(:nestoria) do

      add :bathroom_number, :integer
      add :bedroom_number, :integer
      add :car_spaces, :integer
      add :commission, :float
      add :construction_year, :integer
      add :datasource_name, :string
      add :floor, :float
      add :img_height, :integer
      add :img_url, :string
      add :img_width, :integer
      add :keywords, :string
      add :latitude, :float
      add :lister_name, :string
      add :lister_url, :string
      add :listing_type, :string
      add :location_accuracy, :integer
      add :longitude, :float
      add :price, :float
      add :price_currency, :string
      add :price_formatted, :string
      add :price_high, :float
      add :price_low, :float
      add :price_type, :string
      add :property_type, :string
      add :size, :float
      add :size_type, :string
      add :summary, :string
      add :thumb_height, :integer
      add :thumb_url, :string
      add :thumb_width, :integer
      add :title, :string
      add :updated_in_days, :integer
      add :updated_in_days_formatted, :string
      add :date_added, :naive_datetime
      add :location_reference, :string

      timestamps
    end
  end
end
