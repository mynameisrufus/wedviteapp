class RenameMispeltStationeryForiegnKeys < ActiveRecord::Migration
  def up
    rename_column :stationery_images, :stationary_id, :stationery_id
    rename_column :stationery_assets, :stationary_id, :stationery_id
    rename_column :weddings, :stationary_id, :stationery_id
  end

  def down
    rename_column :stationery_images, :stationery_id, :stationary_id
    rename_column :stationery_assets, :stationery_id, :stationary_id
    rename_column :weddings, :stationery_id, :stationary_id
  end
end
