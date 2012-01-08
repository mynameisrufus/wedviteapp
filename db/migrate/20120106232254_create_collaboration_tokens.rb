class CreateCollaborationTokens < ActiveRecord::Migration
  def change
    create_table :collaboration_tokens do |t|
      t.string :role
      t.string :email

      t.references :wedding, null: false

      t.string :token, null: false
      
      t.datetime :claimed_on
      t.timestamps
    end

    add_index :collaboration_tokens, :token, unique: true
    add_index :collaboration_tokens, :wedding_id
  end
end
