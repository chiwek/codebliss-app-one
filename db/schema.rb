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

ActiveRecord::Schema.define(version: 20150720185426) do

  create_table "shop_collections", force: :cascade do |t|
    t.integer  "shops_id",           limit: 4
    t.string   "name",               limit: 120, null: false
    t.integer  "shop_collection_id", limit: 4,   null: false
    t.datetime "checked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_collections", ["shops_id"], name: "index_shop_collections_on_shops_id", using: :btree

  create_table "shop_options", force: :cascade do |t|
    t.integer "shops_id", limit: 4
  end

  add_index "shop_options", ["shops_id"], name: "index_shop_options_on_shops_id", using: :btree

  create_table "shop_products", force: :cascade do |t|
    t.integer  "shop_collections_id", limit: 4
    t.string   "name",                limit: 120, null: false
    t.integer  "shop_product_id",     limit: 4,   null: false
    t.datetime "checked_at"
    t.datetime "published_at"
    t.integer  "order_num",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_products", ["shop_collections_id"], name: "index_shop_products_on_shop_collections_id", using: :btree

  create_table "shop_stats", force: :cascade do |t|
    t.integer  "shops_id",       limit: 4
    t.integer  "execution_time", limit: 4,     null: false
    t.string   "action_call",    limit: 255,   null: false
    t.text     "log",            limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_stats", ["shops_id"], name: "index_shop_stats_on_shops_id", using: :btree

  create_table "shops", force: :cascade do |t|
    t.string   "shopify_domain", limit: 120, null: false
    t.string   "shopify_token",  limit: 120, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true, using: :btree

end
