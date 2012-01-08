class CreateAgencyDesigners < ActiveRecord::Migration
  def change
    create_table :agency_designers do |t|
      t.references :agency
      t.references :designer
        
      t.string :role

      t.timestamps
    end

    add_index :agency_designers, :agency_id
    add_index :agency_designers, :designer_id
  end
end
