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

ActiveRecord::Schema.define(version: 20160305042357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string   "path_with_namespace", null: false, comment: "repository path/namespace set"
    t.string   "web_url",             null: false, comment: "repository web page url"
    t.string   "http_url_to_repo",    null: false, comment: "http url in repository"
    t.string   "ssh_url_to_repo",     null: false, comment: "SSH URL in repository"
    t.datetime "last_activity_at",                 comment: "user last activity timing"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "projects", ["web_url"], name: "index_projects_on_web_url", unique: true, using: :btree

end
