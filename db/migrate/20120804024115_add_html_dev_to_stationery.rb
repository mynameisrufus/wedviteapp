class AddHtmlDevToStationery < ActiveRecord::Migration
  def up
    add_column :stationeries, :html_dev, :text
    add_column :stationeries, :example_wording_dev, :text
    add_column :stationeries, :deployed_at, :datetime
  end

  def down
    remove_column :stationeries, :html_dev
    remove_column :stationeries, :example_wording_dev
    remove_column :stationeries, :deployed_at
  end
end
