class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text   :address_components
      t.text   :types
      t.string :formatted_address
      t.string :formatted_phone_number
      t.string :international_phone_number
      t.string :name
      t.string :vicinity
      t.string :website
      t.string :google_url
      t.string :google_id

      t.decimal :lat,   :precision => 16, :scale => 13
      t.decimal :lng,   :precision => 16, :scale => 13

      t.timestamps
    end
  end
end
