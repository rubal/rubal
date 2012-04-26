# Тествоый пример плагина
#p "test_plugin loaded"
require "rubal_core/plugin"

# код плагина
module RubalTestPlugin
  class RubalTestPlugin < RubalCore::Plugin
    module Methods

      # действия плагина
      def say_hello_admin
        #render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddAdminController )</h1>"
        render :file => 'plugin_view.erb', :layout => 'application.html.erb'
      end
      def say_hello_page
        render :inline =>  "<h1>hello world :id=#{params[:id]} (added by AddPageController  )</h1>"
      end

    end

    def initialize
      @routes =[
          {"admin/c1/:id" => "admin#say_hello_admin"},
          {"page/c1/:id" => "admin#say_hello_page"},
          {"admin/i" => "admin#index"}
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

RubalCore::PluginManager.instance.add_plugin RubalTestPlugin::RubalTestPlugin.new
