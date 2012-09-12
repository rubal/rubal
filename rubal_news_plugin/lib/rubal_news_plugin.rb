#encoding: utf-8

require "rubal_news_plugin/engine"
require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)

module RubalNewsPlugin

  class RubalNews < RubalCore::RubalPlugin
    def get_substitutions
      return @substitutions
    end

    def get_description
      return {:name => "Новости", :version => 0.01, :plugin_substitution_name => "news"}
    end

    def initialize
      RubalCore::PluginManager.instance.register_plugin self

      @substitutions = []

      before_save = lambda { |params, page|
          page.additional_params= {:trend_id => params[:trend_id].to_i}
      }

      form_params = {:before_save => before_save, :additional_form_fields => "/news/page_additional_form_fields.html.erb"}

      RubalCore::PluginManager.instance.register_page_type(self, 'news_normal', 'Новости', "Страница с новостями", 'news#news_with_trend', form_params)

      @substitutions.push(RubalCore::RubalSubstitution.new(self, "size", "<%= @news.size %>", "Количество новостей", :only => :news_normal))
      @substitutions.push(RubalCore::RubalSubstitution.new(self, "begin", "<% @news.each{|n| %>", "Начало вывода новостей", :only => :news_normal))
      @substitutions.push(RubalCore::RubalSubstitution.new(self, "end", "<% } %>", "Окончание вывода новостей", :only => :news_normal))
      @substitutions.push(RubalCore::RubalSubstitution.new(self, "header", "<%= n.header %>", "Заголовок", :only => :news_normal))
      @substitutions.push(RubalCore::RubalSubstitution.new(self, "content", "<%= n.content %>", "Содержание новости", :only => :news_normal))

      RubalCore::PluginManager.instance.register_menu_node('Новости', :news_index, [{:name => 'Новостные разделы', :url => :news_trends}])

      permission_manager = RubalCore::PermissionManager.instance

      permission_manager.add_permission(self, "Редактировать новости", "Только редактирование", "news_edit", {:news => [:edit, :update]}, :members)
      permission_manager.add_permission(self, "Создавать новости", "Только создание", "news_create", {:news => [:new, :create]}, :members)
      permission_manager.add_permission(self, "Удалять новости", "Только удаление", "news_delete", {:news => :destroy}, :admins)
      permission_manager.add_permission(self, "Просматривать новости", "Только просмотр", "news_index", {:news => :index}, :admins)
    end
  end
end

RubalNewsPlugin::RubalNews.new
