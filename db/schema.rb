# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_30_035414) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "resume"
    t.integer "year"
    t.decimal "credit"
    t.bigint "user_id", null: false
    t.boolean "has_interest"
    t.boolean "donated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.boolean "capital", default: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "donations", force: :cascade do |t|
    t.string "address"
    t.string "status"
    t.date "date_delivery"
    t.bigint "book_id", null: false
    t.integer "receiver_id"
    t.boolean "donor_evaluation", default: false
    t.boolean "receiver_evaluation", default: false
    t.integer "donor_note"
    t.integer "receiver_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_donations_on_book_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "url"
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_pictures_on_book_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state_code"
    t.string "code"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "credits", default: "0.0"
    t.decimal "points", default: "0.0"
    t.string "phone"
    t.bigint "city_id"
    t.integer "count_note"
    t.integer "sum_notes"
    t.index ["city_id"], name: "index_users_on_city_id"
  end

  add_foreign_key "books", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "donations", "books"
  add_foreign_key "pictures", "books"
  add_foreign_key "users", "cities"
end
