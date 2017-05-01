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

ActiveRecord::Schema.define(version: 20170430221043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.integer "trackable_id"
    t.string "trackable_type"
    t.integer "owner_id"
    t.string "owner_type"
    t.string "key"
    t.text "parameters"
    t.integer "recipient_id"
    t.string "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "trackable_name"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.string "slug"
    t.string "name", default: "", null: false
    t.string "postcode"
    t.string "country", default: "", null: false
    t.string "division", default: "", null: false
    t.string "city"
    t.string "street"
    t.string "phone"
    t.string "email"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_contacts_on_code", unique: true
    t.index ["slug"], name: "index_contacts_on_slug", unique: true
  end

  create_table "finance_accounts", id: :serial, force: :cascade do |t|
    t.integer "ledger_id", null: false
    t.string "name", null: false
    t.string "description"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon", limit: 32
    t.index ["ledger_id"], name: "index_finance_accounts_on_ledger_id"
  end

  create_table "finance_budgets", id: :serial, force: :cascade do |t|
    t.integer "ledger_id", null: false
    t.string "description"
    t.text "memo"
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_finance_budgets_on_ledger_id"
  end

  create_table "finance_categories", id: :serial, force: :cascade do |t|
    t.integer "ledger_id", null: false
    t.integer "type", default: 0, null: false
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_finance_categories_on_ledger_id"
    t.index ["type"], name: "index_finance_categories_on_type"
  end

  create_table "finance_journalizings", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "category_id", null: false
    t.integer "transactions_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_finance_journalizings_on_account_id"
    t.index ["category_id"], name: "index_finance_journalizings_on_category_id"
  end

  create_table "finance_ledgers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.date "started_at"
    t.date "finished_at"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_finance_ledgers_on_state"
  end

  create_table "finance_transactions", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "journalizing_id"
    t.integer "type", default: 0, null: false
    t.string "title", null: false
    t.integer "total_amount", default: 0, null: false
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_finance_transactions_on_account_id"
    t.index ["journalizing_id"], name: "index_finance_transactions_on_journalizing_id"
    t.index ["type"], name: "index_finance_transactions_on_type"
  end

  create_table "involvements", id: :serial, force: :cascade do |t|
    t.string "holder_type"
    t.integer "holder_id"
    t.string "matter_type"
    t.integer "matter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["holder_type", "holder_id"], name: "index_involvements_on_holder_type_and_holder_id"
    t.index ["matter_type", "matter_id"], name: "index_involvements_on_matter_type_and_matter_id"
  end

  create_table "locker_room_mateships", id: :serial, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.integer "role", limit: 2, default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_locker_room_mateships_on_team_id"
    t.index ["user_id"], name: "index_locker_room_mateships_on_user_id"
  end

  create_table "locker_room_teams", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.integer "type_id"
    t.string "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_locker_room_teams_on_subdomain"
    t.index ["subscription_id"], name: "index_locker_room_teams_on_subscription_id"
    t.index ["type_id"], name: "index_locker_room_teams_on_type_id"
  end

  create_table "locker_room_types", id: :serial, force: :cascade do |t|
    t.string "plan_id"
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_locker_room_types_on_plan_id"
  end

  create_table "locker_room_users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale", limit: 5, default: "en", null: false
    t.index ["email"], name: "index_locker_room_users_on_email", unique: true
    t.index ["username"], name: "index_locker_room_users_on_username", unique: true
  end

  create_table "snippets", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.text "content_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "userships", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_userships_on_contact_id"
    t.index ["user_id"], name: "index_userships_on_user_id"
  end

end
