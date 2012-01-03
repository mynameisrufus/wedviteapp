class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name, null: false
      t.string :taxation_reference
      t.string :account_number

      t.references :designer

      t.timestamps
    end
  end
end
