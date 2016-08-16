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

ActiveRecord::Schema.define(version: 20160816041519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "charge"
    t.integer  "reminder_before"
    t.integer  "reminder_after"
    t.string   "status"
    t.text     "notes"
    t.integer  "calendar_id"
    t.integer  "client_id"
    t.integer  "bill_id"
    t.integer  "employee_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "uuid"
    t.string   "service"
    t.string   "description"
    t.boolean  "archived",        default: false
  end

  add_index "appointments", ["bill_id"], name: "index_appointments_on_bill_id", using: :btree
  add_index "appointments", ["calendar_id"], name: "index_appointments_on_calendar_id", using: :btree
  add_index "appointments", ["client_id"], name: "index_appointments_on_client_id", using: :btree
  add_index "appointments", ["employee_id"], name: "index_appointments_on_employee_id", using: :btree

  create_table "bills", force: :cascade do |t|
    t.integer  "total_amount"
    t.integer  "paid_amount"
    t.datetime "date_billed"
    t.datetime "date_paid"
    t.integer  "discount"
    t.integer  "client_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "archived",     default: false
  end

  add_index "bills", ["client_id"], name: "index_bills_on_client_id", using: :btree

  create_table "calendars", force: :cascade do |t|
    t.string   "name"
    t.string   "server_incoming"
    t.string   "server_outgoing"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "url"
    t.string   "uid"
    t.string   "apitype"
    t.string   "color"
    t.integer  "company_id"
    t.boolean  "archived",        default: false
  end

  add_index "calendars", ["company_id"], name: "index_calendars_on_company_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "first_name",                   null: false
    t.string   "last_name",                    null: false
    t.string   "email"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "phone4"
    t.string   "address"
    t.text     "notes"
    t.integer  "company_id"
    t.string   "first_name_2"
    t.string   "last_name_2"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "archived",     default: false
  end

  add_index "clients", ["company_id"], name: "index_clients_on_company_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "archived",    default: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",                    null: false
    t.string   "last_name",                     null: false
    t.string   "username"
    t.string   "password"
    t.integer  "company_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "user_id"
    t.string   "provider"
    t.boolean  "is_admin?"
    t.boolean  "is_superuser?"
    t.boolean  "archived",      default: false
  end

  add_index "employees", ["company_id"], name: "index_employees_on_company_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.datetime "date_received"
    t.decimal  "amount"
    t.string   "ref"
    t.string   "memo"
    t.integer  "client_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "payment_type"
  end

  add_index "payments", ["client_id"], name: "index_payments_on_client_id", using: :btree

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "client_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "archived",   default: false
  end

  add_index "pets", ["client_id"], name: "index_pets_on_client_id", using: :btree

  create_table "service_types", force: :cascade do |t|
    t.string   "name"
    t.string   "price"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "company_id"
    t.string   "billing_display_name"
  end

  add_index "service_types", ["company_id"], name: "index_service_types_on_company_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  add_foreign_key "appointments", "bills"
  add_foreign_key "appointments", "calendars"
  add_foreign_key "appointments", "clients"
  add_foreign_key "appointments", "employees"
  add_foreign_key "bills", "clients"
  add_foreign_key "calendars", "companies"
  add_foreign_key "clients", "companies"
  add_foreign_key "employees", "companies"
  add_foreign_key "payments", "clients"
  add_foreign_key "pets", "clients"
  add_foreign_key "service_types", "companies"
end
