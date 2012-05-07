require 'rubal_core'
include RubalCore

class AdminController < ApplicationController
  # подключаем админскую часть модуля
  # extend добавляет методы класса
  #extend AdminExtend
  # include добавляет методы экземпляра
  include RubalCore::PluginManager::AdminExtend

  def index
    # Создаем главное меню (Единственное!)
    # Выводим главное меню
    @out_mm = MainMenu.instance

    t = PagePluginUsingTable.new


  end
end
