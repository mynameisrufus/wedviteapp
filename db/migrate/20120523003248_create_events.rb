class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :headline, null: false
      t.text :quotation
      t.string :state

      t.references :eventfull, polymorphic: true, null: false
      t.references :wedding, null: false

      t.timestamps
    end

    add_index :events, :wedding_id
  end
end
