class CreatePromotionalCodes < ActiveRecord::Migration
  def change
    create_table :promotional_codes do |t|
      t.string :code,         null: false
      t.integer :limit,       null: false, default: 0
      t.integer :claimed,     null: false, default: 0
      t.float :discount,      null: false, default: 0.0
      t.datetime :expires_on, null: false

      t.timestamps
    end

    add_index :promotional_codes, :code, unique: true
  end
end
