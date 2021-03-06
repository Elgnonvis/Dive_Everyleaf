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

ActiveRecord::Schema.define(version: 2021_10_07_070521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.string "label_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_label_relations", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_task_label_relations_on_label_id"
    t.index ["task_id"], name: "index_task_label_relations_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.text "task_details", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 1
    t.string "status", default: "Unstarted"
    t.datetime "deadline", default: -> { "CURRENT_TIMESTAMP" }
    t.bigint "user_id"
    t.index ["task_name"], name: "index_tasks_on_task_name", unique: true
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "username"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "task_label_relations", "labels"
  add_foreign_key "task_label_relations", "tasks"
  add_foreign_key "tasks", "users"
end
