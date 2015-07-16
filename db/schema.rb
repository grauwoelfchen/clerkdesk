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

ActiveRecord::Schema.define(version: 20150715185513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.integer  "finance_id",              null: false
    t.string   "title",                   null: false
    t.text     "description"
    t.integer  "carryover",   default: 0, null: false
    t.datetime "approved_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "budgets", ["finance_id"], name: "index_budgets_on_finance_id", using: :btree

  create_table "finance_categories", force: :cascade do |t|
    t.integer  "finance_id",             null: false
    t.integer  "type",       default: 0, null: false
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "finance_categories", ["finance_id"], name: "index_finance_categories_on_finance_id", using: :btree
  add_index "finance_categories", ["type"], name: "index_finance_categories_on_type", using: :btree

  create_table "finances", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.date     "started_at"
    t.date     "finished_at"
    t.integer  "state",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "finances", ["state"], name: "index_finances_on_state", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "person_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["person_id"], name: "index_identities_on_person_id", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "involvements", force: :cascade do |t|
    t.string   "holder_type"
    t.integer  "holder_id"
    t.string   "matter_type"
    t.integer  "matter_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "involvements", ["holder_type", "holder_id"], name: "index_involvements_on_holder_type_and_holder_id", using: :btree
  add_index "involvements", ["matter_type", "matter_id"], name: "index_involvements_on_matter_type_and_matter_id", using: :btree

  create_table "journalizings", force: :cascade do |t|
    t.integer  "ledger_id",                 null: false
    t.integer  "category_id",               null: false
    t.integer  "entries_count", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "journalizings", ["category_id"], name: "index_journalizings_on_category_id", using: :btree
  add_index "journalizings", ["ledger_id"], name: "index_journalizings_on_ledger_id", using: :btree

  create_table "ledger_entries", force: :cascade do |t|
    t.integer  "ledger_id",                   null: false
    t.integer  "journalizing_id"
    t.integer  "type",            default: 0, null: false
    t.string   "title",                       null: false
    t.integer  "total_amount",    default: 0, null: false
    t.string   "memo"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "ledger_entries", ["journalizing_id"], name: "index_ledger_entries_on_journalizing_id", using: :btree
  add_index "ledger_entries", ["ledger_id"], name: "index_ledger_entries_on_ledger_id", using: :btree
  add_index "ledger_entries", ["type"], name: "index_ledger_entries_on_type", using: :btree

  create_table "ledgers", force: :cascade do |t|
    t.integer  "finance_id",  null: false
    t.string   "title",       null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ledgers", ["finance_id"], name: "index_ledgers_on_finance_id", using: :btree

  create_table "locker_room_memberships", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "role",       limit: 2, default: 1
    t.string   "name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "locker_room_memberships", ["team_id"], name: "index_locker_room_memberships_on_team_id", using: :btree
  add_index "locker_room_memberships", ["user_id"], name: "index_locker_room_memberships_on_user_id", using: :btree

  create_table "locker_room_teams", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locker_room_teams", ["subdomain"], name: "index_locker_room_teams_on_subdomain", using: :btree

  create_table "locker_room_users", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "username"
    t.string   "email",                                     null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "locale",           limit: 5, default: "en", null: false
  end

  add_index "locker_room_users", ["team_id", "email"], name: "index_locker_room_users_on_team_id_and_email", unique: true, using: :btree
  add_index "locker_room_users", ["team_id", "username"], name: "index_locker_room_users_on_team_id_and_username", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "content_html"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "slug",                    null: false
    t.string   "property"
    t.string   "first_name", default: "", null: false
    t.string   "last_name",  default: "", null: false
    t.string   "postcode"
    t.string   "country",    default: "", null: false
    t.string   "division",   default: "", null: false
    t.string   "city",       default: "", null: false
    t.string   "address",    default: "", null: false
    t.string   "phone"
    t.string   "email"
    t.string   "memo"
    t.datetime "joined_at"
    t.datetime "left_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "people", ["slug"], name: "index_people_on_slug", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
