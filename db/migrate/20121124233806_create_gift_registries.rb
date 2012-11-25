class CreateGiftRegistries < ActiveRecord::Migration
  def up
    create_table :gift_registries do |t|
      t.text :details

      t.references :wedding, null: false

      t.timestamps
    end

    add_index :gift_registries, :wedding_id
  end

  def down
    drop_table :gift_registries
  end
end
