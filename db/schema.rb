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

ActiveRecord::Schema.define(version: 20160525063921) do

  create_table "chats", force: :cascade do |t|
    t.text     "title",      limit: 65535
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "chats_users", id: false, force: :cascade do |t|
    t.integer "chat_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "chats_users", ["chat_id"], name: "index_chats_users_on_chat_id", using: :btree
  add_index "chats_users", ["user_id"], name: "index_chats_users_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "task_id",       limit: 4
    t.integer  "wansungdo_log", limit: 4
    t.string   "comment_log",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "filemessages", force: :cascade do |t|
    t.integer  "message_id",        limit: 4
    t.integer  "chat_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "filemessageupload", limit: 255
  end

  create_table "imagemessages", force: :cascade do |t|
    t.integer  "message_id",         limit: 4
    t.integer  "chat_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "imagemessageupload", limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "chat_id",     limit: 4
    t.integer  "sender_id",   limit: 4
    t.text     "content",     limit: 65535
    t.integer  "messagetype", limit: 4,     default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "messages_users", id: false, force: :cascade do |t|
    t.integer "message_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  add_index "messages_users", ["message_id"], name: "index_messages_users_on_message_id", using: :btree
  add_index "messages_users", ["user_id"], name: "index_messages_users_on_user_id", using: :btree

  create_table "resumes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "attachment", limit: 255
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.text     "taskname",   limit: 65535
    t.date     "duedate"
    t.integer  "sender",     limit: 4
    t.integer  "wansungdo",  limit: 4
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.integer "task_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "tasks_users", ["task_id"], name: "index_tasks_users_on_task_id", using: :btree
  add_index "tasks_users", ["user_id"], name: "index_tasks_users_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "teamname",   limit: 255
    t.string   "belong",     limit: 255
    t.string   "location",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "teams_users", ["team_id"], name: "index_teams_users_on_team_id", using: :btree
  add_index "teams_users", ["user_id"], name: "index_teams_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "last_seen"
    t.string   "image",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "whiteboards", force: :cascade do |t|
    t.integer  "chat_id",    limit: 4
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.boolean  "edit"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
