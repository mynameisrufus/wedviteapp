class CreateAgencyDesignerTokens < ActiveRecord::Migration
  def change
    create_table :agency_designer_tokens do |t|
      t.string :role
      t.string :email

      t.references :agency, null: false

      t.string :token, null: false

      t.datetime :claimed_on
      t.timestamps
    end

    add_index :agency_designer_tokens, :token, unique: true
    add_index :agency_designer_tokens, :agency_id
  end
end
