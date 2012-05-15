class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text

      t.references :guest

      t.timestamps
    end
    
    add_index :messages, :guest_id
  end
end
