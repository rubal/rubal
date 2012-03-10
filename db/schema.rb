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

ActiveRecord::Schema.define(:version => 20120303091654) do

  create_table "news", :force => true do |t|
    t.datetime "date"
    t.text     "short_text"
    t.text     "full_text"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "header"
    t.string   "trend_name", :default => "news"
  end

  create_table "news_trends", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.integer  "full_template_id"
    t.integer  "short_template_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "news_trends", ["full_template_id"], :name => "index_news_trends_on_full_template_id"
  add_index "news_trends", ["short_template_id"], :name => "index_news_trends_on_short_template_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "path"
    t.integer  "parent_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "url"
    t.integer  "role",       :default => 1, :null => false
    t.integer  "template"
    t.string   "subst_name"
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
