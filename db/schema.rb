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

ActiveRecord::Schema.define(version: 20130510130129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followings", force: true do |t|
    t.integer  "user_id"
    t.integer  "followed_id"
    t.string   "followed_type", limit: 16
    t.datetime "created_at"
  end

  add_index "followings", ["followed_id", "followed_type"], name: "index_followings_on_followed_id_and_followed_type"
  add_index "followings", ["user_id"], name: "index_followings_on_user_id"

  create_table "members", force: true do |t|
    t.integer  "space_id"
    t.integer  "user_id"
    t.integer  "node_id"
    t.string   "auth_token",            limit: 50
    t.datetime "auth_token_created_at"
    t.boolean  "active",                           default: true
    t.integer  "login_count",                      default: 0
    t.datetime "last_login_at"
    t.datetime "created_at"
  end

  add_index "members", ["node_id"], name: "index_members_on_node_id"
  add_index "members", ["space_id"], name: "index_members_on_space_id"
  add_index "members", ["user_id"], name: "index_members_on_user_id"

  create_table "mentions", force: true do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "space_id"
  end

  add_index "mentions", ["from_id"], name: "index_mentions_on_from_id"
  add_index "mentions", ["space_id"], name: "index_mentions_on_space_id"
  add_index "mentions", ["to_id"], name: "index_mentions_on_to_id"

  create_table "nodes", force: true do |t|
    t.string   "title",           limit: 300
    t.string   "slug",            limit: 300
    t.string   "image",           limit: 300
    t.text     "body"
    t.integer  "user_id"
    t.integer  "space_id"
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
    t.integer  "followers_count",             default: 0
  end

  add_index "nodes", ["parent_id"], name: "index_nodes_on_parent_id"
  add_index "nodes", ["slug"], name: "index_nodes_on_slug"
  add_index "nodes", ["space_id", "parent_id"], name: "index_nodes_on_space_id_and_parent_id"
  add_index "nodes", ["space_id"], name: "index_nodes_on_space_id"
  add_index "nodes", ["user_id"], name: "index_nodes_on_user_id"

  create_table "spaces", force: true do |t|
    t.string   "name",            limit: 100
    t.integer  "members_count",               default: 0
    t.integer  "node_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nodes_count",                 default: 0
    t.integer  "mentions_count",              default: 0
    t.integer  "followers_count",             default: 0
    t.string   "host",            limit: 100
  end

  add_index "spaces", ["host"], name: "index_spaces_on_host"
  add_index "spaces", ["node_id"], name: "index_spaces_on_node_id"
  add_index "spaces", ["user_id"], name: "index_spaces_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name",             limit: 100
    t.string   "slug",             limit: 100
    t.string   "email",            limit: 200
    t.boolean  "admin",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nodes_count",                  default: 0
    t.integer  "followings_count",             default: 0
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

end
