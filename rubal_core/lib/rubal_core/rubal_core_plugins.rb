#encoding: utf-8
require_relative '../rubal_core'
require_relative './rubal_plugin'
module RubalCore
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
      plugin_manager.register_page_type self, 'layout', 'Шаблон', "Внешнее обрамление для страниц", nil, {:form_fields => []}

      @substitutions = []

      @substitutions.push RubalSubstitution.new(self, "title", "<%= @page.title %>", "Заголовок")

      @substitutions.push RubalSubstitution.new(self, "page_text", "<%= get_page_content_for(@page.id) %>", "Текст страницы")

      @substitutions.push RubalSubstitution.new(self, "content", "<%= yield %>", "Контент страницы", :only => :layout)

      plugin_manager.register_menu_node('Страницы', :pages)

      PermissionManager.instance.add_permission(self, "Тестовое разрешение", "Просто посмотрим как работает", "test_permission", {:pages => [:show, :edit]}, :admins)
    end
  end

  class RubalBasicPlugin < RubalPlugin
    def get_description
      return {:name => "Базовый функционал", :version => 0.01, :plugin_substitution_name => "basic"}
    end

    def initialize
      @substitutions = []

      plugin_manager = RubalCore::PluginManager.instance

      plugin_manager.register_plugin self

      plugin_manager.register_menu_node('Пользователи', :browse_users, [{:name => "Группы", :url => :user_groups}, {:name => "Разрешения", :url => :permissions}])

      PermissionManager.instance.add_permission(self, "Тестовое разрешение", "Просто посмотрим как работает", "test_permission", {:pages => [:show, :edit]}, :admins)
      PermissionManager.instance.add_permission(self, "Регистрация", "Регистрация нового пользователя", "user_registration", {:rubal_registrations => [:new, :create]}, :guests)
    end
  end
end

RubalCore::RubalPagePlugin.new
RubalCore::RubalBasicPlugin.new