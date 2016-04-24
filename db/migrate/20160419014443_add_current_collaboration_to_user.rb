class AddCurrentCollaborationToUser < ActiveRecord::Migration
  def change
    add_column :users, :collaborator_id, :integer
  end
end
