#encoding: utf-8

require "rubal_news_plugin/engine"
require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)

module RubalNewsPlugin

  class RubalNews < RubalCore::RubalPlugin
    def get_substitutions
      return @substitutions
    end

    def get_description
      return {:name => "News plugin", :version => 0.01, :plugin_substitution_name => "news"}
    end

    def initialize
      RubalCore::PluginManager.instance.register_plugin self

      @substitutions = []
      after_save_block = lambda {
          |params, page|
          puts "HELLO FROM LAMBDA EXPRESSION _ "
          page.additional_params= {:trend_id => params[:trend_id].to_i}
      }
      RubalCore::PluginManager.instance.register_page_type self, 'news_normal', 'Новости', "Страница с новостями", 'news#news_with_trend', after_save_block

      @substitutions.push RubalCore::RubalSubstitution.new(self, "size", "<%= @news.size %>", "Количество новостей", :only => :news_normal)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "begin", "<% @news.each{|n| %>", "Начало вывода новостей", :only => :news_normal)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "end", "<% } %>", "Окончание вывода новостей", :only => :news_normal)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "header", "<%= n.header %>", "Заголовок", :only => :news_normal)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "content", "<%= n.content %>", "Содержание новости", :only => :news_normal)

      RubalCore::PluginManager.instance.register_menu_node('News', :news_index, [{:name => 'News trends', :url => :news_trends}])
    end
  end
end

RubalNewsPlugin::RubalNews.new
