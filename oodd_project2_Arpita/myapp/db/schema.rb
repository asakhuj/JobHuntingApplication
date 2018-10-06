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

ActiveRecord::Schema.define(version: 20181005224331) do

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "house_hunters", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.string "name", null: false
    t.string "phone", null: false
    t.string "contact_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "location", null: false
    t.string "square_footage", null: false
    t.string "year_built", null: false
    t.string "style", null: false
    t.string "price", null: false
    t.string "number_of_floors", null: false
    t.string "basement", null: false
    t.string "current_house_owner", null: false
    t.string "contact_info_of_realtor", null: false
    t.integer "real_estate_company_id"
    t.integer "house_hunter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "realtor_id"
    t.string "file_name"
    t.index ["house_hunter_id"], name: "index_houses_on_house_hunter_id"
    t.index ["real_estate_company_id"], name: "index_houses_on_real_estate_company_id"
    t.index ["realtor_id"], name: "index_houses_on_realtor_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "subject", null: false
    t.string "message_content", null: false
    t.integer "house_hunter_id"
    t.integer "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_hunter_id"], name: "index_inquiries_on_house_hunter_id"
    t.index ["house_id"], name: "index_inquiries_on_house_id"
  end

  create_table "interest_lists", force: :cascade do |t|
    t.integer "house_hunter_id"
    t.integer "house_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_hunter_id"], name: "index_interest_lists_on_house_hunter_id"
    t.index ["house_id"], name: "index_interest_lists_on_house_id"
  end

  create_table "real_estate_companies", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "website", null: false
    t.string "address", null: false
    t.string "size_of_company", null: false
    t.string "founded_year", null: false
    t.string "revenue", null: false
    t.string "synopsis", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "realtors", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.string "name", null: false
    t.string "phone", null: false
    t.integer "real_estate_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_estate_company_id"], name: "index_realtors_on_real_estate_company_id"
  end

  create_table "reply_to_inquiries", force: :cascade do |t|
    t.text "reply", null: false
    t.integer "inquiry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inquiry_id"], name: "index_reply_to_inquiries_on_inquiry_id"
  end

end
