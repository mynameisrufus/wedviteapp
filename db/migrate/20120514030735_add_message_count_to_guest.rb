class AddMessageCountToGuest < ActiveRecord::Migration
  def up
    add_column :guests, :messages_count, :integer, default: 0
  end

  def down
    remove_column :guests, :messages_count
  end
end
