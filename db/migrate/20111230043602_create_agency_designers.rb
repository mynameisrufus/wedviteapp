class CreateAgencyDesigners < ActiveRecord::Migration
  def change
    create_table :agency_designers do |t|
      t.references :agency
      t.references :designer
        
      t.string :role

      t.timestamps
    end
  end
end
