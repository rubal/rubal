# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 first_admin = User.new(:email => "admin@rubal.ru", :password =>  "adminpass", :password_confirmation =>  "adminpass")
 first_admin.user_group= UserGroup.find_by_key('admins')
 first_admin.save
