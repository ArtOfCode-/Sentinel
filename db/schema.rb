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

ActiveRecord::Schema.define(version: 20161123003059) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.string   "repo"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "authorized_bots", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deletion_logs", force: :cascade do |t|
    t.integer  "post_id"
    t.boolean  "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_deletion_logs_on_post_id"
  end

  create_table "feedback_types", force: :cascade do |t|
    t.string   "name"
    t.string   "short_code"
    t.string   "character"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "feedback_type_id"
    t.integer  "chat_id"
    t.string   "chat_username"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["feedback_type_id"], name: "index_feedbacks_on_feedback_type_id"
    t.index ["post_id"], name: "index_feedbacks_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "link"
    t.datetime "post_creation_date"
    t.string   "user_link"
    t.string   "username"
    t.integer  "user_reputation"
    t.float    "nato_score"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "answer_id"
  end

  create_table "posts_reasons", force: :cascade do |t|
    t.integer "post_id"
    t.integer "reason_id"
  end

  create_table "reasons", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "stack_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "network_id"
    t.integer  "chat_so_id"
    t.integer  "chat_se_id"
    t.integer  "chat_mse_id"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "username"
    t.index ["user_id"], name: "index_stack_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "auth_state"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
