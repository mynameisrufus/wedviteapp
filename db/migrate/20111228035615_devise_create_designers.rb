class DeviseCreateDesigners < ActiveRecord::Migration
  def change
    create_table(:designers) do |t|
      t.string   :email,                  default: "", null: false
      t.string   :encrypted_password,     default: "", null: false, limit: 128
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count,          default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :first_name
      t.string :last_name
      t.text :biography

      t.timestamps
    end

    add_index :designers, :email,                unique: true
    add_index :designers, :reset_password_token, unique: true
  end
end
