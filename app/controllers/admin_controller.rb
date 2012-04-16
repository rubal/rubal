#require File.expand_path('../../../lib/menu', __FILE__)

require 'rubal_core'
include RubalCore


class AdminController < ApplicationController

  # подключаем админскую часть модуля
  include AdminExtend

  def index
    # Создаем главное меню (Единственное!)
    #mm = MainMenu.instance
    # Выводим главное меню
    @out_mm = MainMenu.instance
    #render :file => 'RubalTestPlugin\lib\views\plugin_view.erb', :layout => 'application.html.erb'

  end

  def say_hello_admin
    @out_mm = MainMenu.instance
    #render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddAdminController )</h1>"
    #render :file => 'plugin_view.erb', :layout => 'application.html.erb'
    render :file => Rails.root + 'RubalTestPlugin\lib\views\view.erb', :layout => ' application.html.erb'
  end
end
