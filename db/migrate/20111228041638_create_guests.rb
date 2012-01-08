class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :state
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.integer :adults, default: 1
      t.integer :children, default: 0
      t.boolean :attending_reception, default: true
      t.datetime :invited_on
      t.datetime :replyed_on

      t.references :wedding

      t.string :token, null: false

      t.timestamps
    end

    add_index :guests, :wedding_id
    add_index :guests, :token, unique: true
  end
end
