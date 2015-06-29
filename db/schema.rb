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

ActiveRecord::Schema.define(version: 20150604171250) do

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

  create_table "documents", force: true do |t|
    t.string   "description"
    t.string   "attachment"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "exports", force: true do |t|
    t.integer  "item_id"
    t.string   "container"
    t.string   "booking"
    t.string   "loading"
    t.string   "port"
    t.string   "party"
    t.string   "agent"
    t.string   "remarks"
    t.string   "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funds", force: true do |t|
    t.integer  "amount"
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
    t.datetime "date"
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

  create_table "lines", force: true do |t|
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.integer  "quantity"
    t.float    "price"
    t.string   "code"
    t.string   "item_title"
    t.integer  "gross"
    t.integer  "tear"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sale_id"
  end

  create_table "parents", force: true do |t|
    t.string   "relation"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "dob"
    t.string   "education"
    t.string   "occupation"
    t.integer  "income"
    t.string   "email"
    t.string   "officePhone1"
    t.string   "officePhone2"
    t.string   "cellPhone"
    t.string   "officeAddress1"
    t.string   "officeAddress2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "customer_id"
    t.integer  "advance"
    t.integer  "paid"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remarks"
    t.datetime "date"
  end

  create_table "salaries", force: true do |t|
    t.integer  "employee_id"
    t.integer  "loan_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.string   "bookNum"
    t.string   "customerName"
    t.string   "customerMobile"
    t.float    "paid"
    t.string   "status"
    t.string   "driver"
    t.integer  "customer_id"
    t.string   "vehicle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "branch"
    t.string   "grade"
    t.integer  "amount"
    t.integer  "paid",                default: 0
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
    t.string   "middleName"
    t.string   "lastName"
    t.string   "batch"
    t.string   "blood"
    t.string   "birthPlace"
    t.string   "nationality"
    t.string   "language"
    t.string   "religion"
    t.string   "category"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phone"
    t.string   "address2"
    t.string   "pinCode"
    t.string   "image"
    t.integer  "fee"
    t.string   "term"
    t.string   "dueDate"
    t.string   "previousInstitute"
    t.string   "year"
    t.string   "totalMarks"
    t.string   "obtainedMarks"
    t.integer  "parent_id"
    t.integer  "emergency_parent_id"
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
