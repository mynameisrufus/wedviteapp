class AddActiveToGiftRegistry < ActiveRecord::Migration
  def change
    add_column :gift_registries, :active, :boolean, default: false, null: false
  end
end
