# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_04_025216) do

  create_table "api_keys", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.string "repo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "authorized_bots", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deletion_logs", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "post_id"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_deletion_logs_on_post_id"
  end

  create_table "feedback_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "short_code"
    t.string "character", limit: 250
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "post_id"
    t.integer "feedback_type_id"
    t.integer "chat_id"
    t.string "chat_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_username"], name: "index_feedbacks_on_chat_username"
    t.index ["feedback_type_id"], name: "index_feedbacks_on_feedback_type_id"
    t.index ["post_id"], name: "index_feedbacks_on_post_id"
  end

  create_table "flags", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.string "flag_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_flags_on_post_id"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "posts", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "title"
    t.text "body", size: :medium
    t.string "link"
    t.datetime "post_creation_date"
    t.string "user_link"
    t.string "username"
    t.integer "user_reputation"
    t.float "nato_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_id"
    t.integer "site_id"
    t.integer "reasons_count"
    t.integer "feedbacks_count"
    t.index ["site_id"], name: "index_posts_on_site_id"
  end

  create_table "posts_reasons", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "post_id"
    t.integer "reason_id"
    t.index ["post_id", "reason_id"], name: "post_id"
    t.index ["post_id", "reason_id"], name: "post_id_2"
    t.index ["post_id", "reason_id"], name: "post_id_3", unique: true
  end

  create_table "reasons", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "posts_count"
  end

  create_table "roles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "sites", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "logo"
    t.string "domain"
    t.boolean "is_child_meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stack_users", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "network_id"
    t.integer "chat_so_id"
    t.integer "chat_se_id"
    t.integer "chat_mse_id"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["user_id"], name: "index_stack_users_on_user_id"
  end

  create_table "users", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "auth_state"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "deletion_logs", "posts"
  add_foreign_key "feedbacks", "feedback_types"
  add_foreign_key "feedbacks", "posts"
  add_foreign_key "flags", "posts"
  add_foreign_key "flags", "users"
  add_foreign_key "posts", "sites"
  add_foreign_key "stack_users", "users"
end
