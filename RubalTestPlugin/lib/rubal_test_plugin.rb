# Тествоый пример плагина
#p "test_plugin loaded"
require "rubal_core/plugin_manager"

include RubalCore

# код плагина
module RubalTestPlugin
  # действия плагина
  def say_hello_admin
    #render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddAdminController )</h1>"
    render :file => 'plugin_view.erb', :layout => 'application.html.erb'
  end
  def say_hello_page
    render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddPageController  )</h1>"
  end
  # возвращает пути в виде массива хэшей, содержащих пути вида
  # [{"admin/c1/:id" => "admin#call_me_baybe"}, {"admin/i" => "admin#index"}]
  def get_my_routes_please
    [
        {"admin/c1/:id" => "admin#say_hello_admin"},
        {"page/c1/:id" => "admin#say_hello_page"},
        {"admin/i" => "admin#index"}
    ]
  end

  def get_my_placeholders_btch
    [
        {
            :category=>'test',
            :param=>'hello',
            :value=>'Hello from Rubal developers'
        },
        {
            :category=>'test',
            :param=>'title',
            :value=>'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
        }
    ]
  end

  # функция для вызова метода модуля
  # e.g. RubalTestPlugin.get_my_routes_please
  module_function :get_my_routes_please
  module_function :get_my_placeholders_btch
end

plugin_manager = PluginManager.instance

# добавление в AdminController
plugin_manager.add_admin_controller RubalTestPlugin
# добавление в PageController
plugin_manager.add_page_controller  RubalTestPlugin
# собираем пути из плагинов
RubalTestPlugin.get_my_routes_please.each{ |route|
  plugin_manager.add_route route
}

RubalTestPlugin.get_my_placeholders_btch.each{ |placeholder|
  plugin_manager.add_placeholder( placeholder[:category], placeholder[:param], placeholder[:value] )
}

