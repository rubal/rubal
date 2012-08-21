#encoding: utf-8

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
      return {:name => "Rubal pages", :version => 0.01, :plugin_substitution_name => "page"}
    end

    def initialize
      RubalCore::PluginManager.instance.register_plugin self

      RubalCore::PluginManager.instance.register_page_type self, 'page', 'Страница', "Обычная страница со всеми доступными подстановками"
      RubalCore::PluginManager.instance.register_page_type self, 'layout', 'Шаблон', "Внешнее обрамление для страниц"

      @substitutions = []

      @substitutions.push RubalSubstitution.new(self, "title", "<%= @page.title %>", "Page title")

      @substitutions.push RubalSubstitution.new(self, "page_text", "<%= get_page_content_for(@page.id) %>", "Текст страницы")

      @substitutions.push RubalSubstitution.new(self, "content", "<%= yield %>", "Page content", :only => :layout)

      RubalCore::PluginManager.instance.register_menu_node('Pages', :pages, [{:name => 'Texts', :url => :page_contents}])
    end
  end
end

RubalCore::RubalPagePlugin.new