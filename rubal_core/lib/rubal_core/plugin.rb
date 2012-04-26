require 'rubal_core/plugin_manager'

module RubalCore
  class Plugin
    def initialize
      raise "Plugin child must contain fields @placeholdersm, @routes, @module" if @placeholders.nil? || @routes.nil? ||  @module.nil?
      plugin_manager = PluginManager.instance

      # добавление в AdminController
      plugin_manager.add_admin_controller @module

      # добавление в PageController
      plugin_manager.add_page_controller @module

      @placeholders.each{ |placeholder|
        plugin_manager.add_placeholder( placeholder[:category], placeholder[:param], placeholder[:value] )
      }

      # собираем пути из плагинов
      @routes.each{ |route|
        plugin_manager.add_route route
      }
    end
  end

end