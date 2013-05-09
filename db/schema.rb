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

ActiveRecord::Schema.define(:version => 20130507001949) do

  create_table "classifications", :force => true do |t|
    t.string "name"
    t.text   "short_description"
    t.text   "long_description"
    t.string "image_url"
    t.string "path"
  end

  create_table "crafts", :force => true do |t|
    t.string  "name"
    t.text    "short_description"
    t.text    "long_description"
    t.string  "image_url"
    t.string  "path"
    t.integer "classification_id", :limit => 255
    t.string  "full_path"
  end

  create_table "levels", :force => true do |t|
    t.string "name"
    t.string "icon_url"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "author"
    t.text     "description"
    t.string   "image_url"
    t.integer  "upvotes"
    t.string   "link"
    t.string   "path"
    t.integer  "craft_id",            :limit => 255
    t.string   "full_path"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "user_id"
    t.integer  "upvotes_count"
    t.integer  "level_id"
    t.integer  "type_id"
  end

  create_table "types", :force => true do |t|
    t.string "name"
    t.string "icon_url"
  end

  create_table "upvotes", :force => true do |t|
    t.integer "user_id"
    t.integer "resource_id"
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.string  "email"
    t.string  "first_name"
    t.string  "last_name"
    t.text    "bio"
    t.string  "avatar_url"
    t.string  "password_digest"
    t.string  "remember_token"
    t.boolean "panel",           :default => true
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
