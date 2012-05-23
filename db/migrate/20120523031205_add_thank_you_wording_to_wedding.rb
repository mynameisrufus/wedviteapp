class AddThankYouWordingToWedding < ActiveRecord::Migration
  def up
    add_column :weddings, :thank_you_wording, :text
  end

  def down
    remove_column :weddings, :thank_you_wording
  end
end
