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

ActiveRecord::Schema.define(version: 20171101131551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "mac_address"
    t.string "name"
    t.string "user_agent"
    t.datetime "last_activity_at", default: "2017-10-25 13:10:45", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_lines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.decimal "price", null: false
    t.decimal "vat", null: false
    t.decimal "vat_rate", null: false
    t.uuid "ordered_by_id"
    t.uuid "invoice_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_invoice_lines_on_invoice_id"
  end

  create_table "invoices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "team_id", null: false
    t.datetime "invoiced_at"
    t.decimal "total", null: false
    t.decimal "vat", null: false
    t.decimal "total_brut", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoiced_at"], name: "index_invoices_on_invoiced_at"
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "team_id", null: false
    t.decimal "amount", null: false
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.boolean "available_in_kiosk", default: false, null: false
    t.decimal "price", null: false
    t.decimal "vat", null: false
    t.decimal "vat_rate", null: false
    t.boolean "deprecated", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["available_in_kiosk"], name: "index_products_on_available_in_kiosk"
    t.index ["deprecated"], name: "index_products_on_deprecated"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.uuid "team_id", null: false
    t.datetime "canceled_at"
    t.integer "interval", default: 0, null: false
    t.datetime "next_renewal_at", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canceled_at"], name: "index_subscriptions_on_canceled_at"
    t.index ["next_renewal_at"], name: "index_subscriptions_on_next_renewal_at"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "billing_address"
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_teams_on_slug"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.uuid "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "last_activity_at", default: -> { "now()" }, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug"
  end

  add_foreign_key "devices", "users"
  add_foreign_key "invoice_lines", "invoices"
  add_foreign_key "invoice_lines", "products"
  add_foreign_key "invoice_lines", "users", column: "ordered_by_id"
  add_foreign_key "invoices", "teams"
  add_foreign_key "payments", "teams"
  add_foreign_key "subscriptions", "products"
  add_foreign_key "subscriptions", "teams"
  add_foreign_key "users", "teams"
end
