class CreateStationaryAssets < ActiveRecord::Migration
  def change
    create_table :stationary_assets do |t|
      t.references :stationary
 
      t.timestamps
    end

    add_index :stationary_assets, :stationary_id
  end
end
