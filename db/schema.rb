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

ActiveRecord::Schema.define(version: 20161023204157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "can_hosts", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "can_hosts", ["event_id"], name: "index_can_hosts_on_event_id", using: :btree
  add_index "can_hosts", ["venue_id"], name: "index_can_hosts_on_venue_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "sport_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "game_datetime"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "games_tables", force: :cascade do |t|
    t.integer  "sport_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "event_datetime"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "venue_id"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree
  add_index "reviews", ["venue_id"], name: "index_reviews_on_venue_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "longitude"
    t.text     "address"
    t.float    "latitude"
  end

  add_foreign_key "can_hosts", "events"
  add_foreign_key "can_hosts", "venues"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "venues"
end
