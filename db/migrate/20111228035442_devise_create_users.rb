class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string   :email,                    default: "", null: false
      t.string   :encrypted_password,       default: "", null: false, limit: 128
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count,            default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :first_name
      t.string :last_name

      t.string :billing_name
      t.string :billing_address
      t.string :billing_state
      t.string :billing_country
      t.string :billing_zip
      t.string :billing_city
      t.integer :chargify_subscription_id
      t.string :masked_card_number

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
