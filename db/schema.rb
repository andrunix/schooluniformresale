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

ActiveRecord::Schema.define(version: 20150904183650) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "description",  limit: 255
    t.decimal  "price",                    precision: 5, scale: 2
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "category_id",  limit: 4
    t.integer  "condition_id", limit: 4
    t.integer  "school_id",    limit: 4
    t.string   "size",         limit: 255
    t.string   "brand",        limit: 255
    t.integer  "quantity",     limit: 4
    t.string   "image",        limit: 255
    t.datetime "expires_on"
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "from_user_id",      limit: 4
    t.integer  "to_user_id",        limit: 4
    t.integer  "parent_message_id", limit: 4
    t.string   "subject",           limit: 255
    t.string   "message",           limit: 255
    t.integer  "item_id",           limit: 4
    t.boolean  "unread",            limit: 1
    t.integer  "folder_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "city",        limit: 255
    t.string   "state",       limit: 255
    t.string   "zip",         limit: 255
    t.string   "url",         limit: 255
    t.string   "email",       limit: 255
    t.boolean  "approved",    limit: 1
    t.integer  "created_by",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_friends", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "friend_id",  limit: 4
    t.datetime "add_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname",                  limit: 255
    t.string   "lname",                  limit: 255
    t.string   "email",                  limit: 255
    t.string   "phone",                  limit: 255
    t.string   "zip",                    limit: 255
    t.integer  "role_id",                limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  create_table "users_schools", force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "school_id", limit: 4
  end

  add_index "users_schools", ["user_id", "school_id"], name: "index_users_schools_on_user_id_and_school_id", using: :btree
  add_index "users_schools", ["user_id"], name: "index_users_schools_on_user_id", using: :btree

  add_foreign_key "items", "users"
end
