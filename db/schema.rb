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

ActiveRecord::Schema.define(:version => 20120428110618) do

  create_table "foobars", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "foos", :force => true do |t|
    t.integer  "bar"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_plugin_relations", :force => true do |t|
    t.integer  "pid"
    t.string   "plugin_name"
    t.string   "plugin_params"
    t.string   "plugin_returned_html"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "erb_path"
    t.string   "vhtml_path"
    t.string   "page_url"
    t.string   "used_plugins"
    t.string   "page_title"
    t.string   "html_returned_by_plugins"
    t.integer  "parent_page"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "superpages", :force => true do |t|
    t.string   "erb_path"
    t.string   "vhtml_path"
    t.string   "page_url"
    t.string   "used_plugins"
    t.string   "page_title"
    t.string   "html_returned_by_plugins"
    t.integer  "parent_page"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

end
