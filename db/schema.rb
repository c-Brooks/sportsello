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

ActiveRecord::Schema.define(version: 20161024233542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id"
    t.integer  "venue_id"
  end

  add_index "events", ["game_id"], name: "index_events_on_game_id", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "sport_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "game_datetime"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "team1_id_id"
    t.integer  "team2_id_id"
  end

  add_index "games", ["team1_id", "team2_id", "game_datetime"], name: "index_games_on_team1_id_and_team2_id_and_game_datetime", unique: true, using: :btree
  add_index "games", ["team1_id_id"], name: "index_games_on_team1_id_id", using: :btree
  add_index "games", ["team2_id_id"], name: "index_games_on_team2_id_id", using: :btree

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

  add_foreign_key "events", "games"
  add_foreign_key "events", "venues"
  add_foreign_key "games", "sports"
  add_foreign_key "games", "teams", column: "team1_id"
  add_foreign_key "games", "teams", column: "team2_id"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "venues"
end
