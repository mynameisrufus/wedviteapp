# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120515065821) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "agencies", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "taxation_reference"
    t.string   "account_number"
    t.integer  "designer_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "agencies", ["designer_id"], :name => "index_agencies_on_designer_id"

  create_table "agency_designer_tokens", :force => true do |t|
    t.string   "role"
    t.string   "email"
    t.integer  "agency_id",  :null => false
    t.string   "token",      :null => false
    t.datetime "claimed_on"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "agency_designer_tokens", ["agency_id"], :name => "index_agency_designer_tokens_on_agency_id"
  add_index "agency_designer_tokens", ["token"], :name => "index_agency_designer_tokens_on_token", :unique => true

  create_table "agency_designers", :force => true do |t|
    t.integer  "agency_id"
    t.integer  "designer_id"
    t.string   "role"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "agency_designers", ["agency_id"], :name => "index_agency_designers_on_agency_id"
  add_index "agency_designers", ["designer_id"], :name => "index_agency_designers_on_designer_id"

  create_table "collaboration_tokens", :force => true do |t|
    t.string   "role"
    t.string   "email"
    t.integer  "wedding_id", :null => false
    t.string   "token",      :null => false
    t.datetime "claimed_on"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaboration_tokens", ["token"], :name => "index_collaboration_tokens_on_token", :unique => true
  add_index "collaboration_tokens", ["wedding_id"], :name => "index_collaboration_tokens_on_wedding_id"

  create_table "collaborators", :force => true do |t|
    t.string   "role"
    t.integer  "user_id"
    t.integer  "wedding_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaborators", ["user_id"], :name => "index_collaborators_on_user_id"
  add_index "collaborators", ["wedding_id"], :name => "index_collaborators_on_wedding_id"

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "guest_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["guest_id"], :name => "index_comments_on_guest_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "designers", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "designers", ["email"], :name => "index_designers_on_email", :unique => true
  add_index "designers", ["reset_password_token"], :name => "index_designers_on_reset_password_token", :unique => true

  create_table "guests", :force => true do |t|
    t.string   "state"
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.integer  "adults",               :default => 1
    t.integer  "children",             :default => 0
    t.boolean  "attending_reception",  :default => true
    t.datetime "invited_on"
    t.datetime "replyed_on"
    t.integer  "partner_number"
    t.integer  "comments_count",       :default => 0
    t.integer  "wedding_id"
    t.integer  "position"
    t.string   "token",                                  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "messages_count",       :default => 0
    t.boolean  "invited_to_reception", :default => true
  end

  add_index "guests", ["token"], :name => "index_guests_on_token", :unique => true
  add_index "guests", ["wedding_id"], :name => "index_guests_on_wedding_id"

  create_table "locations", :force => true do |t|
    t.text     "address_components"
    t.text     "types"
    t.string   "formatted_address"
    t.string   "formatted_phone_number"
    t.string   "international_phone_number"
    t.string   "name"
    t.string   "vicinity"
    t.string   "website"
    t.string   "google_url"
    t.string   "google_id"
    t.decimal  "lat",                        :precision => 16, :scale => 13
    t.decimal  "lng",                        :precision => 16, :scale => 13
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "text"
    t.integer  "guest_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["guest_id"], :name => "index_messages_on_guest_id"

  create_table "stationaries", :force => true do |t|
    t.string   "name"
    t.string   "style"
    t.text     "description"
    t.text     "html"
    t.boolean  "desktop",     :default => true
    t.boolean  "mobile",      :default => false
    t.boolean  "print",       :default => false
    t.boolean  "published",   :default => false
    t.integer  "popularity"
    t.float    "price"
    t.float    "commision"
    t.integer  "agency_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "stationaries", ["agency_id"], :name => "index_stationaries_on_agency_id"
  add_index "stationaries", ["popularity"], :name => "index_stationaries_on_popularity"
  add_index "stationaries", ["price"], :name => "index_stationaries_on_price"
  add_index "stationaries", ["style"], :name => "index_stationaries_on_style"

  create_table "stationary_assets", :force => true do |t|
    t.integer  "stationary_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "stationary_assets", ["stationary_id"], :name => "index_stationary_assets_on_stationary_id"

  create_table "stationary_images", :force => true do |t|
    t.integer  "stationary_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "stationary_images", ["stationary_id"], :name => "index_stationary_images_on_stationary_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                   :default => "", :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "billing_name"
    t.string   "billing_address"
    t.string   "billing_state"
    t.string   "billing_country"
    t.string   "billing_zip"
    t.string   "billing_city"
    t.integer  "chargify_subscription_id"
    t.string   "masked_card_number"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weddings", :force => true do |t|
    t.string   "name"
    t.text     "wording"
    t.text     "save_the_date_wording"
    t.text     "ceremony_only_wording"
    t.datetime "respond_deadline"
    t.datetime "ceremony_when"
    t.text     "ceremony_how"
    t.text     "ceremony_what"
    t.boolean  "has_reception",         :default => true
    t.datetime "reception_when"
    t.text     "reception_how"
    t.text     "reception_what"
    t.string   "partner_one_name"
    t.string   "partner_two_name"
    t.boolean  "payment_made"
    t.datetime "payment_date"
    t.integer  "stationary_id"
    t.integer  "ceremony_location_id"
    t.integer  "reception_location_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.datetime "ceremony_when_end"
    t.datetime "reception_when_end"
  end

  add_index "weddings", ["stationary_id"], :name => "index_weddings_on_stationary_id"

end
