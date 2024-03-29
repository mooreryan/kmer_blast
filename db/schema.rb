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

ActiveRecord::Schema.define(version: 20130731181826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "headers", id: false, force: true do |t|
    t.string "header", null: false
    t.string "source"
  end

  create_table "long_tetra_infos", id: false, force: true do |t|
    t.string  "header",                      null: false
    t.string  "tetranucleotide",  limit: 4,  null: false
    t.float   "tud",                         null: false
    t.integer "actual_num",       limit: 8,  null: false
    t.float   "expected_num",                null: false
    t.string  "calculation_date", limit: 25
  end

  create_table "r_squared_values", id: false, force: true do |t|
    t.string "header_1",  null: false
    t.string "header_2",  null: false
    t.float  "r_squared", null: false
  end

  create_table "sequences", force: true do |t|
    t.text     "sequence",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mer_size",   limit: 2, null: false
  end

  create_table "tetra_infos", id: false, force: true do |t|
    t.string "header", null: false
    t.text   "info",   null: false
  end

end
