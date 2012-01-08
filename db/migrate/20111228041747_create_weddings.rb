class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.string :name
      t.text :title
      t.datetime :wedding_when
      t.string :wedding_where
      t.text :wedding_how
      t.text :wedding_what
      t.boolean :has_reception, default: true
      t.datetime :reception_when
      t.string :reception_where
      t.text :reception_how
      t.text :reception_what

      t.boolean :payment_made
      t.datetime :payment_date
      
      t.references :stationary

      t.timestamps
    end

    add_index :weddings, :stationary_id
  end
end
