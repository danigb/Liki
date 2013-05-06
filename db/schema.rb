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

ActiveRecord::Schema.define(version: 20130506215256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: true do |t|
    t.string   "name",           limit: 100
    t.integer  "members_count",              default: 0
    t.integer  "node_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nodes_count",                default: 0
    t.integer  "mentions_count",             default: 0
  end

  add_index "groups", ["node_id"], name: "index_groups_on_node_id"
  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "members", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "node_id"
    t.string   "auth_token",            limit: 50
    t.datetime "auth_token_created_at"
    t.boolean  "active",                           default: true
    t.integer  "login_count",                      default: 0
    t.datetime "last_login_at"
    t.datetime "created_at"
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id"
  add_index "members", ["node_id"], name: "index_members_on_node_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "mentions", force: true do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "group_id"
  end

  add_index "mentions", ["from_id"], name: "index_mentions_on_from_id"
  add_index "mentions", ["group_id"], name: "index_mentions_on_group_id"
  add_index "mentions", ["to_id"], name: "index_mentions_on_to_id"

  create_table "nodes", force: true do |t|
    t.string   "title",           limit: 300
    t.string   "slug",            limit: 300
    t.string   "image",           limit: 300
    t.text     "body"
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "children_count",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mentions_solved",             default: false
    t.integer  "mentioned_count",             default: 0
    t.integer  "mentions_count",              default: 0
    t.string   "document",        limit: 300
    t.string   "style",           limit: 8
  end

  add_index "nodes", ["group_id", "parent_id"], name: "index_nodes_on_group_id_and_parent_id"
  add_index "nodes", ["group_id"], name: "index_nodes_on_group_id"
  add_index "nodes", ["parent_id"], name: "index_nodes_on_parent_id"
  add_index "nodes", ["slug"], name: "index_nodes_on_slug"
  add_index "nodes", ["user_id"], name: "index_nodes_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name",        limit: 100
    t.string   "slug",        limit: 100
    t.string   "email",       limit: 200
    t.boolean  "admin",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nodes_count",             default: 0
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

end
