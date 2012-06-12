class FixStationerySpellingMistake < ActiveRecord::Migration
  def up
    rename_table :stationaries, :stationeries
    rename_table :stationary_images, :stationery_images
    rename_table :stationary_assets, :stationery_assets
  end

  def down
    rename_table :stationeries, :stationaries
    rename_table :stationery_images,  :stationary_images
    rename_table :stationery_assets,  :stationary_assets
  end
end
