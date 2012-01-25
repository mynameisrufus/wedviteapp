class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :commenter

      t.references :guest
      t.references :user

      t.timestamps
    end
    
    add_index :comments, :user_id
    add_index :comments, :guest_id
  end
end
