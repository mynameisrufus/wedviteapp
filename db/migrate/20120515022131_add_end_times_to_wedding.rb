class AddEndTimesToWedding < ActiveRecord::Migration
  def change
    change_table :weddings do |t|
      t.datetime :ceremony_when_end
      t.datetime :reception_when_end
    end
  end
end
