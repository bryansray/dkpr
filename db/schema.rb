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

ActiveRecord::Schema.define(:version => 20101211043425) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.float    "default_on_time_points",   :default => 5.0, :null => false
    t.float    "default_full_time_points", :default => 5.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjustments", :force => true do |t|
    t.integer  "adjustee_id"
    t.string   "adjustee_type"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attempts", :force => true do |t|
    t.integer  "raid_id"
    t.integer  "boss_id"
    t.boolean  "successful"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendees", :force => true do |t|
    t.integer  "raid_id"
    t.integer  "character_id"
    t.float    "on_time_points",   :default => 0.0, :null => false
    t.float    "full_time_points", :default => 0.0, :null => false
    t.datetime "joined_at"
    t.datetime "left_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bosses", :force => true do |t|
    t.string   "name"
    t.integer  "value",      :default => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_classes", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", :force => true do |t|
    t.integer  "character_class_id"
    t.string   "name"
    t.integer  "level"
    t.boolean  "active",             :default => true
    t.integer  "account_id",                           :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dkps", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drops", :force => true do |t|
    t.integer  "item_id"
    t.integer  "attendee_id"
    t.integer  "raid_id"
    t.integer  "boss_id"
    t.integer  "price"
    t.datetime "looted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "number"
    t.integer  "count"
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kills", :force => true do |t|
    t.integer  "raid_id"
    t.integer  "boss_id"
    t.integer  "attendee_id"
    t.boolean  "present",     :default => true
    t.datetime "killed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer  "attempt_id"
    t.integer  "character_id"
    t.boolean  "present",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raids", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.text     "xml"
    t.text     "note"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "account_id"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
