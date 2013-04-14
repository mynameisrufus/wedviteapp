class AddThankedOnToGuests < ActiveRecord::Migration
  def up
    add_column :guests, :thanked_on, :datetime
  end

  def down
    remove_column :guests, :thanked_on
  end
end
