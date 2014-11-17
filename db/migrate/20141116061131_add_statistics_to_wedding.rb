class AddStatisticsToWedding < ActiveRecord::Migration
  def change
    add_column :weddings, :statistics, :text
  end
end
