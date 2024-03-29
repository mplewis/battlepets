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

ActiveRecord::Schema.define(version: 20160710040912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "matches", force: :cascade do |t|
    t.string   "contest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performances", force: :cascade do |t|
    t.float    "score"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "pet_id"
    t.integer  "match_id"
    t.boolean  "complete",   default: false
  end

  add_index "performances", ["match_id"], name: "index_performances_on_match_id", using: :btree
  add_index "performances", ["pet_id"], name: "index_performances_on_pet_id", using: :btree

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.integer  "strength"
    t.integer  "agility"
    t.integer  "wit"
    t.integer  "perception"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
