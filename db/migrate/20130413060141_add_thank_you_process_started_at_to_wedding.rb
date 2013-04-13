class AddThankYouProcessStartedAtToWedding < ActiveRecord::Migration
  def up
    add_column :weddings, :thank_process_started, :boolean
    add_column :weddings, :thank_process_started_at, :datetime
  end

  def down
    remove_column :weddings, :thank_process_started
    remove_column :weddings, :thank_process_started_at
  end
end
