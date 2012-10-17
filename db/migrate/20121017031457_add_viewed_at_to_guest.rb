class AddViewedAtToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :viewed_at, :datetime
  end
end
