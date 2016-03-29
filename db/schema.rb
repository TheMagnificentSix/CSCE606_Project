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

ActiveRecord::Schema.define(version: 20160329215649) do

  create_table "contact_people", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "salution"
    t.string   "email"
    t.string   "company"
    t.string   "street_address"
    t.string   "city"
    t.string   "state",            default: "Texas"
    t.string   "country",          default: "United States"
    t.integer  "zipcode"
    t.string   "home_phone"
    t.string   "business_phone"
    t.string   "mobile_phone"
    t.string   "created_by"
    t.datetime "created_at",                                 null: false
    t.string   "last_modified_by"
    t.datetime "last_modified_at"
    t.integer  "organization_id"
    t.datetime "updated_at",                                 null: false
  end

  add_index "contact_people", ["organization_id"], name: "index_contact_people_on_organization_id"

  create_table "contacts", force: :cascade do |t|
    t.date     "contact_date"
    t.date     "followup_date"
    t.text     "narrative"
    t.integer  "donor_id"
    t.integer  "contact_person_id"
    t.string   "created_by"
    t.datetime "created_at",        null: false
    t.string   "last_modified_by"
    t.datetime "last_modified_at"
    t.datetime "updated_at",        null: false
  end

  add_index "contacts", ["contact_person_id"], name: "index_contacts_on_contact_person_id"
  add_index "contacts", ["donor_id"], name: "index_contacts_on_donor_id"

  create_table "donors", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "salution"
    t.string   "email"
    t.string   "organization"
    t.string   "company"
    t.string   "street_address"
    t.string   "city"
    t.string   "state",            default: "Texas"
    t.string   "country",          default: "United States"
    t.integer  "zipcode"
    t.string   "home_phone"
    t.string   "business_phone"
    t.string   "created_by"
    t.string   "last_modified_by"
    t.datetime "created_at",                                 null: false
    t.datetime "last_modified_at"
    t.datetime "updated_at",                                 null: false
  end

  create_table "filters", force: :cascade do |t|
    t.string   "table_name"
    t.string   "field_name"
    t.string   "value"
    t.decimal  "min_value"
    t.decimal  "max_value"
    t.string   "created_by"
    t.datetime "created_at",       null: false
    t.string   "last_modified_by"
    t.datetime "last_modified_at"
    t.integer  "report_id"
    t.datetime "updated_at",       null: false
  end

  add_index "filters", ["report_id"], name: "index_filters_on_report_id"

  create_table "finances", force: :cascade do |t|
    t.string   "type"
    t.date     "date"
    t.decimal  "amount"
    t.text     "description"
    t.string   "designation"
    t.integer  "donor_id"
    t.integer  "organization_id"
    t.integer  "contact_id"
    t.string   "created_by"
    t.datetime "created_at",       null: false
    t.string   "last_modified_by"
    t.datetime "last_modified_at"
    t.datetime "updated_at",       null: false
  end

  add_index "finances", ["contact_id"], name: "index_finances_on_contact_id"
  add_index "finances", ["donor_id"], name: "index_finances_on_donor_id"
  add_index "finances", ["organization_id"], name: "index_finances_on_organization_id"

  create_table "functions", force: :cascade do |t|
    t.string   "name"
    t.string   "created_by"
    t.string   "last_modified_by"
    t.datetime "created_at",       null: false
    t.datetime "last_modified_at"
    t.datetime "updated_at",       null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state",            default: "Texas"
    t.string   "country",          default: "United States"
    t.integer  "zipcode"
    t.string   "fax"
    t.string   "created_by"
    t.datetime "created_at",                                 null: false
    t.string   "last_modified_by"
    t.datetime "last_modified_at"
    t.datetime "updated_at",                                 null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "last_run"
    t.string   "created_by"
    t.datetime "created_at",       null: false
    t.string   "last_modified_by"
    t.datetime "last_modified_at"
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "function"
    t.integer  "access_code"
    t.string   "created_by"
    t.string   "last_modified_by"
    t.datetime "created_at",       null: false
    t.datetime "last_modified_at"
    t.datetime "updated_at",       null: false
  end

end
