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

ActiveRecord::Schema.define(version: 20150408115038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: true do |t|
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.integer  "quantity"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.string   "item_title"
    t.integer  "gross"
    t.integer  "tear"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "contact"
    t.integer  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "paid"
    t.integer  "total"
    t.string   "status"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "salary_type"
    t.integer  "loan"
    t.integer  "salary"
    t.string   "contact"
    t.string   "iqama"
    t.string   "expire_iqama"
    t.string   "address_home"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "expenses", force: true do |t|
    t.string   "description"
    t.integer  "amount"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "title"
    t.integer  "fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: true do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.string   "ramark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.string   "bookNum"
    t.string   "customerName"
    t.string   "customerMobile"
    t.string   "right"
    t.string   "left"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "paid"
    t.string   "status"
    t.string   "driver"
    t.integer  "customer_id"
    t.string   "vehicle"
  end

  create_table "items", force: true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "detail"
    t.integer  "sold"
    t.integer  "left"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "payments", force: true do |t|
    t.integer  "customer_id"
    t.integer  "advance"
    t.integer  "paid"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remarks"
  end

  create_table "salaries", force: true do |t|
    t.integer  "employee_id"
    t.integer  "loan_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "branch"
    t.string   "grade"
    t.integer  "amount"
    t.integer  "paid",       default: 0
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "contact"
    t.string   "rollnum"
    t.string   "sirname"
    t.string   "address"
    t.integer  "grade_id"
    t.string   "dob"
    t.string   "gender"
    t.string   "staus"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type",              default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
