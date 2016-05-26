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

ActiveRecord::Schema.define(version: 20160526135951) do

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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uuid"
    t.string   "service"
    t.string   "description"
  end

  add_index "appointments", ["bill_id"], name: "index_appointments_on_bill_id"
  add_index "appointments", ["calendar_id"], name: "index_appointments_on_calendar_id"
  add_index "appointments", ["client_id"], name: "index_appointments_on_client_id"
  add_index "appointments", ["employee_id"], name: "index_appointments_on_employee_id"

  create_table "bills", force: :cascade do |t|
    t.integer  "total_amount"
    t.integer  "paid_amount"
    t.datetime "date_billed"
    t.datetime "date_paid"
    t.integer  "discount"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "bills", ["client_id"], name: "index_bills_on_client_id"

  create_table "calendars", force: :cascade do |t|
    t.string   "name"
    t.string   "server_incoming"
    t.string   "server_outgoing"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "url"
    t.string   "uid"
    t.string   "apitype"
    t.string   "color"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "clients", ["company_id"], name: "index_clients_on_company_id"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "website"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "password"
    t.integer  "company_id"
    t.integer  "calendar_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "employees", ["calendar_id"], name: "index_employees_on_calendar_id"
  add_index "employees", ["company_id"], name: "index_employees_on_company_id"

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pets", ["client_id"], name: "index_pets_on_client_id"

end
