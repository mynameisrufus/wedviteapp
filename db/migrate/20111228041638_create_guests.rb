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
      t.references :created_by_user
      t.references :updated_by_user

      t.string :uid, length: 32, null: false

      t.timestamps
    end

    add_index :guests, :wedding_id
    add_index :guests, :uid, unique: true
  end
end
