class InviteProcessStarted < ActiveRecord::Migration
  def up
    add_column :weddings, :invite_process_started_at, :datetime
    add_column :weddings, :invite_process_started, :boolean
  end

  def down
    remove_column :weddings, :invite_process_started_at
    remove_column :weddings, :invite_process_started
  end
end
