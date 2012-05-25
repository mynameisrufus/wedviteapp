class DefaultPartnerNumberForGuest < ActiveRecord::Migration
  def up
    change_column_default :guests, :partner_number, 1
  end

  def down
    change_column_default :guests, :partner_number, :null
  end
end
