class AddExampleWordingToStationery < ActiveRecord::Migration
  def self.up
    add_column :stationaries, :example_wording, :text
  end

  def self.down
    remove_column :stationaries, :example_wording
  end
end
