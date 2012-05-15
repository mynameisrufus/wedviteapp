class AddInvitedToReceptionToGuest < ActiveRecord::Migration
  def change
    change_table :guests do |t|
      t.boolean :invited_to_reception, default: true
    end
  end
end
