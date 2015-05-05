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

ActiveRecord::Schema.define(version: 20150501220820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "status",      default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.integer  "account_id",              null: false
    t.string   "title",                   null: false
    t.text     "description"
    t.integer  "carryover",   default: 0, null: false
    t.datetime "approved_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "budgets", ["account_id"], name: "index_budgets_on_account_id", using: :btree

  create_table "ledgers", force: :cascade do |t|
    t.integer  "account_id",  null: false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ledgers", ["account_id"], name: "index_ledgers_on_account_id", using: :btree

  create_table "locker_room_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locker_room_accounts", ["subdomain"], name: "index_locker_room_accounts_on_subdomain", using: :btree

  create_table "locker_room_members", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "role",       limit: 2, default: 1
    t.string   "name"
    t.string   "username"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "locker_room_members", ["account_id"], name: "index_locker_room_members_on_account_id", using: :btree
  add_index "locker_room_members", ["user_id"], name: "index_locker_room_members_on_user_id", using: :btree

  create_table "locker_room_users", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "locker_room_users", ["account_id", "email"], name: "index_locker_room_users_on_account_id_and_email", unique: true, using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "content_html"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "settlements", force: :cascade do |t|
    t.integer  "account_id",              null: false
    t.string   "title",                   null: false
    t.text     "description"
    t.integer  "carryover",   default: 0, null: false
    t.datetime "approved_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "settlements", ["account_id"], name: "index_settlements_on_account_id", using: :btree

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
