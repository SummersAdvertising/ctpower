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

ActiveRecord::Schema.define(version: 20141103073413) do

  create_table "accessories", force: true do |t|
    t.integer  "vehicle_id"
    t.string   "title"
    t.text     "context"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.integer  "ranking",    default: 999, null: false
    t.string   "status"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "articles", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "related_product_id"
    t.integer  "ranking",            default: 999, null: false
    t.integer  "status"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boxes", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id"

  create_table "colors", force: true do |t|
    t.integer  "vehicle_id"
    t.string   "hexcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "contacts", force: true do |t|
    t.string   "subject"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id"

  create_table "faqs", force: true do |t|
    t.integer  "box_id"
    t.text     "question"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: true do |t|
    t.integer  "vehicle_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "context"
  end

  create_table "galleries", force: true do |t|
    t.string   "file_name"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "attachment"
    t.string   "type"
    t.integer  "ranking",         default: 999, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.string   "subject"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specs", force: true do |t|
    t.integer  "vehicle_id"
    t.string   "title"
    t.string   "context"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.string   "name"
    t.text     "intro"
    t.string   "phone"
    t.string   "address"
    t.integer  "country"
    t.integer  "city"
    t.integer  "district"
    t.text     "ophour"
    t.text     "latlng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",        precision: 10, scale: 6
    t.decimal  "lng",        precision: 10, scale: 6
  end

  create_table "vehicles", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.text     "cf"
    t.integer  "price"
    t.integer  "price_for_sale"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "title_color"
  end

end
