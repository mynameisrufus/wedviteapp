class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text

      t.references :guest
      t.references :user
      t.references :comment

      t.timestamps
    end
  end
end
