# Тествоый пример плагина
#p "test_plugin loaded"
require "rubal_core/plugin"

# код плагина
module RubalTestPlugin
  class RubalTestPlugin < RubalCore::Plugin
    module Methods
      # действия плагина
      def say_hello_admin
        @out_mm = MainMenu.instance
        #render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddAdminController )</h1>"
        #render :file => 'plugin_view.erb', :layout => 'application.html.erb'
        render :file => Rails.root + 'RubalTestPlugin\lib\views\view.erb', :layout => 'application.html.erb'
        p Rails.root + 'RubalTestPlugin\lib\views\view.erb'
      end
      #:say_hello_admin
      def say_hello_page
        render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddPageController  )</h1>"
      end
    end

    def initialize
      @routes =[
          {"admin/rubal_test_plugin/:id" => "admin#say_hello_admin"},
          {"page/rubal_test_plugin/:id" => "admin#say_hello_page"},
          {"admin/rubal_test_plugin" => "admin#index"}
      ]
      @placeholders = [
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
      @module = Methods
      super
    end
  end
end
p 'ruabl_test_plugin loaded'
RubalCore::PluginManager.instance.add_plugin RubalTestPlugin::RubalTestPlugin.new
RubalCore::PluginManager.instance.add_admin_controller RubalTestPlugin::RubalTestPlugin::Methods
p RubalCore::PluginManager::AdminExtend.instance_methods
#p RubalCore::PluginManager::AdminController.instance_methods