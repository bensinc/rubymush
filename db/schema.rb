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

ActiveRecord::Schema.define(version: 20171011191706) do

  create_table "actions", force: :cascade do |t|
    t.integer "thing_id", limit: 4
    t.string  "name",     limit: 255
    t.string  "code",     limit: 255
  end

  create_table "attributes", force: :cascade do |t|
    t.integer "thing_id", limit: 4
    t.text    "value",    limit: 65535
    t.string  "name",     limit: 255
  end

  create_table "codes", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.text    "code",     limit: 65535
    t.integer "thing_id", limit: 4
    t.string  "url",      limit: 255
  end

  create_table "things", force: :cascade do |t|
    t.integer  "owner_id",            limit: 4
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.integer  "location_id",         limit: 4
    t.string   "password",            limit: 255
    t.datetime "created_at"
    t.datetime "last_login_at"
    t.boolean  "wizard",                            default: false
    t.string   "kind",                limit: 255,   default: "thing"
    t.boolean  "connected",                         default: false
    t.integer  "credits",             limit: 4,     default: 100
    t.datetime "last_interaction_at"
    t.string   "doing",               limit: 255
    t.integer  "destination_id",      limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "password",      limit: 255
    t.datetime "created_at"
    t.datetime "last_login_at"
    t.boolean  "wizard",                    default: false
  end

end
