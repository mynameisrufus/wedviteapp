class CreateStationaries < ActiveRecord::Migration
  def change
    create_table :stationaries do |t|
      t.string :name
      t.string :style
      t.text :description
      t.text :html
      t.boolean :desktop,    default: true
      t.boolean :mobile,     default: false
      t.boolean :print,      default: false
      t.boolean :published,  default: false
      t.integer :popularity

      t.float :price
      t.float :commision
      
      t.references :agency

      t.timestamps
    end

    add_index :stationaries, :popularity
    add_index :stationaries, :style
    add_index :stationaries, :agency_id
  end
end
