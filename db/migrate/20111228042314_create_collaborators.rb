class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :role

      t.references :user
      t.references :wedding

      t.timestamps
    end

    add_index :collaborators, :user_id
    add_index :collaborators, :wedding_id
  end
end
