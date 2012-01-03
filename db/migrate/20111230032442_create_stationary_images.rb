class CreateStationaryImages < ActiveRecord::Migration
  def change
    create_table :stationary_images do |t|
      t.references :stationary 

      t.timestamps
    end

    add_index :stationary_images, :stationary_id
  end
end
