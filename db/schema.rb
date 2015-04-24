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

ActiveRecord::Schema.define(version: 20150424171903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "account_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["account_id"], name: "index_notes_on_account_id", using: :btree

end
