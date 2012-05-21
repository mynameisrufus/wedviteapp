class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :gross, default: 0, null: false
      t.float :transaction_fee, default: 0, null: false
      t.string :currency, null: false

      t.references :purchasable, polymorphic: true, null: false
      t.references :user, null: false

      t.string :transaction_id, null: false
      t.string :gateway, null: false

      t.text :gateway_response

      t.timestamps
    end
  end
end
