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

ActiveRecord::Schema.define(version: 2018_08_21_052707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "etf_constituents", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.decimal "weight", precision: 11, scale: 8
    t.bigint "etf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etf_id"], name: "index_etf_constituents_on_etf_id"
    t.index ["symbol"], name: "index_etf_constituents_on_symbol", unique: true
  end

  create_table "etfs", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_etfs_on_symbol", unique: true
  end

  create_table "etfs_portfolios", id: false, force: :cascade do |t|
    t.bigint "etf_id", null: false
    t.bigint "portfolio_id", null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.string "currency"
    t.bigint "etf_constituent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["etf_constituent_id"], name: "index_prices_on_etf_constituent_id"
  end

  add_foreign_key "prices", "etf_constituents"
end
