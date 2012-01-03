class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :role

      t.references :user
      t.references :wedding

      t.timestamps
    end
  end
end
