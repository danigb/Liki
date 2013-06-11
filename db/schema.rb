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

ActiveRecord::Schema.define(version: 20130611011915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: true do |t|
    t.integer  "user_id"
    t.integer  "node_id"
    t.boolean  "visible",                          default: true
    t.integer  "view_count",                       default: 0
    t.datetime "last_view_at"
    t.integer  "edit_level",                       default: 0
    t.integer  "edit_count",                       default: 0
    t.datetime "last_edit_at"
    t.string   "auth_toker",            limit: 50
    t.datetime "auth_token_created_at"
    t.integer  "auth_token_emailed",               default: 0
    t.integer  "space_id"
  end

  add_index "accesses", ["node_id"], name: "index_accesses_on_node_id", using: :btree
  add_index "accesses", ["space_id"], name: "index_accesses_on_space_id", using: :btree
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.integer  "space_id"
    t.string   "action",         limit: 16
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["space_id"], name: "index_activities_on_space_id", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "followings", force: true do |t|
    t.integer  "user_id"
    t.integer  "followed_id"
    t.string   "followed_type", limit: 16
    t.datetime "created_at"
    t.integer  "space_id"
  end

  add_index "followings", ["followed_id", "followed_type"], name: "index_followings_on_followed_id_and_followed_type", using: :btree
  add_index "followings", ["space_id"], name: "index_followings_on_space_id", using: :btree
  add_index "followings", ["user_id"], name: "index_followings_on_user_id", using: :btree

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

  add_index "members", ["node_id"], name: "index_members_on_node_id", using: :btree
  add_index "members", ["space_id"], name: "index_members_on_space_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "mentions", force: true do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "space_id"
  end

  add_index "mentions", ["from_id"], name: "index_mentions_on_from_id", using: :btree
  add_index "mentions", ["space_id"], name: "index_mentions_on_space_id", using: :btree
  add_index "mentions", ["to_id"], name: "index_mentions_on_to_id", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "title",           limit: 300
    t.string   "slug",            limit: 300
    t.text     "body"
    t.integer  "user_id"
    t.integer  "space_id"
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
    t.integer  "tagged_count",                default: 0
    t.integer  "view_count",                  default: 0
    t.string   "role",            limit: 8
    t.string   "image_style",     limit: 16
    t.boolean  "has_children",                default: false
    t.boolean  "has_photos",                  default: false
    t.string   "children_name",   limit: 30
    t.string   "image_url"
    t.string   "ancestry"
  end

  add_index "nodes", ["ancestry"], name: "index_nodes_on_ancestry", using: :btree
  add_index "nodes", ["role"], name: "index_nodes_on_role", using: :btree
  add_index "nodes", ["slug"], name: "index_nodes_on_slug", using: :btree
  add_index "nodes", ["space_id"], name: "index_nodes_on_space_id", using: :btree
  add_index "nodes", ["user_id"], name: "index_nodes_on_user_id", using: :btree

  create_table "photo_tags", force: true do |t|
    t.integer  "photo_id"
    t.integer  "node_id"
    t.integer  "space_id"
    t.datetime "created_at"
  end

  add_index "photo_tags", ["node_id"], name: "index_photo_tags_on_node_id", using: :btree
  add_index "photo_tags", ["photo_id"], name: "index_photo_tags_on_photo_id", using: :btree
  add_index "photo_tags", ["space_id"], name: "index_photo_tags_on_space_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "space_id"
    t.integer  "user_id"
    t.string   "image"
    t.string   "dropbox_image_url"
    t.string   "body"
    t.string   "style",             limit: 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["space_id"], name: "index_photos_on_space_id", using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "spaces", force: true do |t|
    t.string   "name",             limit: 100
    t.integer  "members_count",                default: 0
    t.integer  "node_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nodes_count",                  default: 0
    t.integer  "mentions_count",               default: 0
    t.integer  "followers_count",              default: 0
    t.string   "host",             limit: 100
    t.string   "email"
    t.string   "background_image"
    t.string   "avatar_image"
    t.boolean  "is_open",                      default: false
    t.integer  "photos_node_id"
  end

  add_index "spaces", ["host"], name: "index_spaces_on_host", using: :btree
  add_index "spaces", ["node_id"], name: "index_spaces_on_node_id", using: :btree
  add_index "spaces", ["user_id"], name: "index_spaces_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "tagged_id"
    t.integer  "position"
    t.datetime "created_at"
    t.integer  "space_id"
  end

  add_index "taggings", ["space_id"], name: "index_taggings_on_space_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["tagged_id"], name: "index_taggings_on_tagged_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",             limit: 100
    t.string   "slug",             limit: 100
    t.string   "email",            limit: 200
    t.boolean  "admin",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nodes_count",                  default: 0
    t.integer  "followings_count",             default: 0
    t.string   "password_digest"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
