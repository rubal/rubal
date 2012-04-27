require 'rubal_core'
include RubalCore

class AdminController < ApplicationController
  def r
    render :file => 'index.html.erb', :layout =>  'application.html.erb'
  end


  #def say_hello_admin
  #  @out_mm = MainMenu.instance
  #  #render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddAdminController )</h1>"
  #  #render :file => 'plugin_view.erb', :layout => 'application.html.erb'
  #  render :file => Rails.root + 'RubalTestPlugin\lib\views\view.erb', :layout => 'application.html.erb'
  #  p Rails.root + 'RubalTestPlugin\lib\views\view.erb'
  #end

  #module Mo
  #  def say_hello_admin
  #    @out_mm = MainMenu.instance
  #    #render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddAdminController )</h1>"
  #    #render :file => 'plugin_view.erb', :layout => 'application.html.erb'
  #    render :file => Rails.root + 'RubalTestPlugin\lib\views\view.erb', :layout => 'application.html.erb'
  #    p Rails.root + 'RubalTestPlugin\lib\views\view.erb'
  #  end
  #end
  #include RubalCore.PluginManager::AdminExtend
  # подключаем админскую часть модуля
  # extend добавляет методы класса
  #extend AdminExtend
  # include добавляет методы экземпляра
  include RubalCore::PluginManager::AdminExtend

  def index
    # Создаем главное меню (Единственное!)
    #mm = MainMenu.instance
    # Выводим главное меню
    @out_mm = MainMenu.instance
    #render :file => 'RubalTestPlugin\lib\views\plugin_view.erb', :layout => 'application.html.erb'

  end
end
