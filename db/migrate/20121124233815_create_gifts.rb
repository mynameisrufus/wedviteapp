class CreateGifts < ActiveRecord::Migration
  def up
    create_table :gifts do |t|
      t.string :description,       null: false
      t.string :url
      t.float :price,              default: 0.0

      t.references :gift_registry, null: false
      t.references :guest

      t.timestamps
    end

    add_index :gifts, :gift_registry_id
  end

  def down
    drop_table :gifts
  end
end
