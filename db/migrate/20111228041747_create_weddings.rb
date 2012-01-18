class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.string :name
      t.text :wording
      t.text :save_the_date_wording
      t.text :ceremony_only_wording
      t.datetime :respond_deadline
      t.datetime :ceremony_when
      t.text :ceremony_how
      t.text :ceremony_what
      t.boolean :has_reception, default: true
      t.datetime :reception_when
      t.text :reception_how
      t.text :reception_what

      t.boolean :payment_made
      t.datetime :payment_date
      
      t.references :stationary
      t.references :ceremony_location
      t.references :reception_location

      t.timestamps
    end

    add_index :weddings, :stationary_id
  end
end
