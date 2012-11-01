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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110901020500) do

  create_table "activities", :force => true do |t|
    t.integer  "minutes"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "from"
  end

  add_index "activities", ["project_id"], :name => "index_activities_on_project_id"

  create_table "commits", :force => true do |t|
    t.integer  "project_id"
    t.datetime "committed_at"
    t.string   "message"
    t.string   "sha"
    t.text     "parents"
    t.string   "author_username"
    t.string   "author_avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commits", ["project_id"], :name => "index_commits_on_project_id"
  add_index "commits", ["sha"], :name => "index_commits_on_sha"

  create_table "invoices", :force => true do |t|
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient"
    t.string   "creator_name"
    t.string   "creator_details"
    t.string   "date"
    t.string   "reference_id"
    t.string   "title"
    t.float    "rate",            :default => 0.0
  end

  add_index "invoices", ["project_id"], :name => "index_invoices_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "html_url"
    t.string   "api_url"
    t.string   "owner_username"
    t.string   "owner_avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.float    "rate"
    t.boolean  "private"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "time_entries", :force => true do |t|
    t.integer  "invoice_id"
    t.text     "description"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commit_id"
  end

  add_index "time_entries", ["commit_id"], :name => "index_time_entries_on_commit_id"
  add_index "time_entries", ["invoice_id"], :name => "index_time_entries_on_invoice_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "access_token"
    t.string   "name"
    t.string   "site_url"
    t.string   "gravatar_token"
    t.boolean  "admin"
    t.string   "github_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
