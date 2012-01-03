class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.database_authenticatable null: false
      t.recoverable
      t.rememberable
      t.trackable
      t.invitable

      t.string :first_name
      t.string :last_name
      t.boolean :can_invite, default: false

      t.string :billing_name
      t.string :billing_address
      t.string :billing_state
      t.string :billing_country
      t.string :billing_zip
      t.string :billing_city
      t.integer :chargify_subscription_id
      t.string :masked_card_number

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :invitation_token,     :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

end
