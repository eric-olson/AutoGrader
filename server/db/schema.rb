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

ActiveRecord::Schema.define(version: 20160523190551) do

  create_table "assignments", force: :cascade do |t|
    t.text     "description"
    t.string   "test_path"
    t.string   "spec_path"
    t.integer  "lab_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assignments", ["lab_id"], name: "index_assignments_on_lab_id"

  create_table "grades", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "grades", ["assignment_id"], name: "index_grades_on_assignment_id"
  add_index "grades", ["user_id"], name: "index_grades_on_user_id"

  create_table "labs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "multipass_id"
    t.string   "code_path"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
