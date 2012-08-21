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

ActiveRecord::Schema.define(:version => 20120820182858) do

  create_table "news", :force => true do |t|
    t.string   "header"
    t.integer  "trend_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news_trends", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_contents", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_types", :force => true do |t|
    t.string   "name"
    t.string   "humanized_name"
    t.string   "description"
    t.string   "plugin_name"
    t.text     "substitutions_params"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "url"
    t.integer  "type_id"
    t.integer  "layout_id"
    t.string   "erb_path"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "rubhtml_content",   :default => "", :null => false
    t.text     "additional_params"
  end

  add_index "pages", ["layout_id"], :name => "index_pages_on_layout_id"

  create_table "plugin_infos", :force => true do |t|
    t.string   "full_name"
    t.string   "subst_name"
    t.string   "path"
    t.string   "resources_path"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "rubal_catalog_plugin_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.integer  "section_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "rubal_catalog_plugin_items", ["section_id"], :name => "index_rubal_catalog_plugin_items_on_section_id"

  create_table "rubal_catalog_plugin_photos", :force => true do |t|
    t.string   "name"
    t.integer  "item_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  add_index "rubal_catalog_plugin_photos", ["item_id"], :name => "index_rubal_catalog_plugin_photos_on_item_id"

  create_table "snippets", :force => true do |t|
    t.string   "name"
    t.string   "subst_name"
    t.string   "path"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
