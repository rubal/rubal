# Тествоый пример плагина
#p "test_plugin loaded"
require "rubal_core/plugin_manager.rb"

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
  # функция для вызова метода модуля
  # e.g. RubalTestPlugin.get_my_routes_please
  module_function :get_my_routes_please
end

# добавление в AdminController
PluginManager.instance.add_admin_controller RubalTestPlugin
# добавление в PageController
PluginManager.instance.add_page_controller  RubalTestPlugin
# собираем пути из плагинов
PluginManager.instance.add_hash_array_routes RubalTestPlugin.get_my_routes_please