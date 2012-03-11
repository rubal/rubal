#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@first_admin = User.new(:email => "admin@rubal.ru", :password =>  "adminpass", :password_confirmation =>  "adminpass")
@first_admin.save

require "pages_helper"
include PagesRoles
@default_index = Page.new(:name => "Главная страница", :path => "/htmls/default/index.html", :url => "index", :title => "Главная страница", :role => roles_hash[:page]["id"],
                          :page_content => "<h1>hi</h1>")
@default_index.save