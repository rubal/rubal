#encoding: utf-8
require_relative '../rubal_core'
module RubalCore
  class RubalPlugin
    def get_substitutions
      return @substitutions
    end

    def get_description
      return {:name => "dummy plugin", :version => 0.001, :plugin_substitution_name => "dummy"}
    end

    def initialize
      @substitutions = []
      RubalCore::PluginManager.instance.register_plugin self
    end
  end


  class RubalPagePlugin < RubalPlugin
    def get_substitutions
      return @substitutions
    end

    def get_description
      return {:name => "Страницы", :version => 0.01, :plugin_substitution_name => "page"}
    end

    def initialize
      plugin_manager = RubalCore::PluginManager.instance

      plugin_manager.register_plugin self

      plugin_manager.register_page_type self, 'page', 'Страница', "Обычная страница со всеми доступными подстановками"
      plugin_manager.register_page_type self, 'layouts', 'Шаблон', "Внешнее обрамление для страниц"

      @substitutions = []

      @substitutions.push RubalSubstitution.new(self, "title", "<%= @page.title %>", "Page title")

      @substitutions.push RubalSubstitution.new(self, "page_text", "<%= get_page_content_for(@page.id) %>", "Текст страницы")

      @substitutions.push RubalSubstitution.new(self, "content", "<%= yield %>", "Page content", :only => :layout)

      plugin_manager.register_menu_node('Страницы', :pages)

      PermissionManager.instance.add_permission(self, "Тестовое разрешение", "Просто посмотрим как работает", "test_permission", {:pages => [:show, :edit]}, :admins)
    end
  end
end

RubalCore::RubalPagePlugin.new