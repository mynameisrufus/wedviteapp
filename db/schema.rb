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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141116061131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "agencies", force: true do |t|
    t.string   "name",               null: false
    t.string   "taxation_reference"
    t.string   "account_number"
    t.integer  "designer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agencies", ["designer_id"], name: "index_agencies_on_designer_id", using: :btree

  create_table "agency_designer_tokens", force: true do |t|
    t.string   "role"
    t.string   "email"
    t.integer  "agency_id",  null: false
    t.string   "token",      null: false
    t.datetime "claimed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agency_designer_tokens", ["agency_id"], name: "index_agency_designer_tokens_on_agency_id", using: :btree
  add_index "agency_designer_tokens", ["token"], name: "index_agency_designer_tokens_on_token", unique: true, using: :btree

  create_table "agency_designers", force: true do |t|
    t.integer  "agency_id"
    t.integer  "designer_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agency_designers", ["agency_id"], name: "index_agency_designers_on_agency_id", using: :btree
  add_index "agency_designers", ["designer_id"], name: "index_agency_designers_on_designer_id", using: :btree

  create_table "authors", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collaboration_tokens", force: true do |t|
    t.string   "role"
    t.string   "email"
    t.integer  "wedding_id", null: false
    t.string   "token",      null: false
    t.datetime "claimed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaboration_tokens", ["token"], name: "index_collaboration_tokens_on_token", unique: true, using: :btree
  add_index "collaboration_tokens", ["wedding_id"], name: "index_collaboration_tokens_on_wedding_id", using: :btree

  create_table "collaborators", force: true do |t|
    t.string   "role"
    t.integer  "user_id"
    t.integer  "wedding_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborators", ["user_id"], name: "index_collaborators_on_user_id", using: :btree
  add_index "collaborators", ["wedding_id"], name: "index_collaborators_on_wedding_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "guest_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["guest_id"], name: "index_comments_on_guest_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "designers", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "designers", ["email"], name: "index_designers_on_email", unique: true, using: :btree
  add_index "designers", ["reset_password_token"], name: "index_designers_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "headline",       null: false
    t.text     "quotation"
    t.string   "state"
    t.integer  "eventfull_id",   null: false
    t.string   "eventfull_type", null: false
    t.integer  "wedding_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "events", ["wedding_id"], name: "index_events_on_wedding_id", using: :btree

  create_table "gift_registries", force: true do |t|
    t.text     "details"
    t.integer  "wedding_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "gift_registries", ["wedding_id"], name: "index_gift_registries_on_wedding_id", using: :btree

  create_table "gifts", force: true do |t|
    t.string   "description",                    null: false
    t.string   "url"
    t.float    "price",            default: 0.0
    t.integer  "gift_registry_id",               null: false
    t.integer  "guest_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "gifts", ["gift_registry_id"], name: "index_gifts_on_gift_registry_id", using: :btree

  create_table "guests", force: true do |t|
    t.string   "state"
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.integer  "adults",               default: 1
    t.integer  "children",             default: 0
    t.boolean  "attending_reception",  default: true
    t.datetime "invited_on"
    t.datetime "replyed_on"
    t.integer  "partner_number",       default: 1
    t.integer  "comments_count",       default: 0
    t.integer  "wedding_id"
    t.integer  "position"
    t.string   "token",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "invited_to_reception", default: true
    t.datetime "viewed_at"
    t.datetime "thanked_on"
  end

  add_index "guests", ["token"], name: "index_guests_on_token", unique: true, using: :btree
  add_index "guests", ["wedding_id"], name: "index_guests_on_wedding_id", using: :btree

  create_table "locations", force: true do |t|
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
    t.decimal  "lat",                        precision: 16, scale: 13
    t.decimal  "lng",                        precision: 16, scale: 13
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "text"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "wedding_id",       null: false
    t.integer  "messageable_id",   null: false
    t.string   "messageable_type", null: false
  end

  add_index "messages", ["messageable_id"], name: "index_messages_on_messageable_id", using: :btree
  add_index "messages", ["messageable_type"], name: "index_messages_on_messageable_type", using: :btree
  add_index "messages", ["wedding_id"], name: "index_messages_on_wedding_id", using: :btree

  create_table "payments", force: true do |t|
    t.float    "gross",            default: 0.0, null: false
    t.float    "transaction_fee",  default: 0.0, null: false
    t.string   "currency",                       null: false
    t.integer  "purchasable_id",                 null: false
    t.string   "purchasable_type",               null: false
    t.integer  "user_id",                        null: false
    t.string   "transaction_id",                 null: false
    t.string   "gateway",                        null: false
    t.text     "gateway_response"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "posts", force: true do |t|
    t.string   "title",                        null: false
    t.text     "body"
    t.string   "slug"
    t.boolean  "published",    default: false
    t.integer  "author_id"
    t.datetime "published_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "promotional_codes", force: true do |t|
    t.string   "code",                     null: false
    t.integer  "limit",      default: 0,   null: false
    t.integer  "claimed",    default: 0,   null: false
    t.float    "discount",   default: 0.0, null: false
    t.datetime "expires_on",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "promotional_codes", ["code"], name: "index_promotional_codes_on_code", unique: true, using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "replies", force: true do |t|
    t.text     "text"
    t.integer  "message_id",     null: false
    t.integer  "replyable_id",   null: false
    t.string   "replyable_type", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "replies", ["message_id"], name: "index_replies_on_message_id", using: :btree
  add_index "replies", ["replyable_id"], name: "index_replies_on_replyable_id", using: :btree
  add_index "replies", ["replyable_type"], name: "index_replies_on_replyable_type", using: :btree

  create_table "stationeries", force: true do |t|
    t.string   "name"
    t.string   "style"
    t.text     "description"
    t.text     "html"
    t.boolean  "desktop",              default: true
    t.boolean  "mobile",               default: false
    t.boolean  "print",                default: false
    t.boolean  "published",            default: false
    t.integer  "popularity"
    t.float    "price"
    t.float    "commision"
    t.integer  "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.text     "example_wording"
    t.text     "html_dev"
    t.text     "example_wording_dev"
    t.datetime "deployed_at"
  end

  add_index "stationeries", ["agency_id"], name: "index_stationaries_on_agency_id", using: :btree
  add_index "stationeries", ["popularity"], name: "index_stationaries_on_popularity", using: :btree
  add_index "stationeries", ["price"], name: "index_stationaries_on_price", using: :btree
  add_index "stationeries", ["style"], name: "index_stationaries_on_style", using: :btree

  create_table "stationery_assets", force: true do |t|
    t.integer  "stationery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "stationery_assets", ["stationery_id"], name: "index_stationary_assets_on_stationary_id", using: :btree

  create_table "stationery_images", force: true do |t|
    t.integer  "stationery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "stationery_images", ["stationery_id"], name: "index_stationary_images_on_stationary_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",       limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weddings", force: true do |t|
    t.string   "name"
    t.text     "wording"
    t.text     "save_the_date_wording"
    t.text     "ceremony_only_wording"
    t.datetime "respond_deadline"
    t.datetime "ceremony_when"
    t.text     "ceremony_how"
    t.text     "ceremony_what"
    t.boolean  "has_reception",             default: true
    t.datetime "reception_when"
    t.text     "reception_how"
    t.text     "reception_what"
    t.string   "partner_one_name"
    t.string   "partner_two_name"
    t.boolean  "payment_made"
    t.datetime "payment_date"
    t.integer  "stationery_id"
    t.integer  "ceremony_location_id"
    t.integer  "reception_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ceremony_when_end"
    t.datetime "reception_when_end"
    t.datetime "invite_process_started_at"
    t.boolean  "invite_process_started"
    t.text     "thank_you_wording"
    t.boolean  "thank_process_started"
    t.datetime "thank_process_started_at"
    t.text     "statistics"
  end

  add_index "weddings", ["stationery_id"], name: "index_weddings_on_stationary_id", using: :btree

end
