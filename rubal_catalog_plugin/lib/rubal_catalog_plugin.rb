#encoding: utf-8

require "rubal_catalog_plugin/engine"
require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)

module RubalCatalogPlugin

  class RubalCatalog < RubalCore::RubalPlugin
    def get_substitutions
      return @substitutions
    end

    def get_description
      return {:name => "Catalog plugin", :version => 0.01, :plugin_substitution_name => "catalog"}
    end

    def initialize
      RubalCore::PluginManager.instance.register_plugin self

      @substitutions = []

      RubalCore::PluginManager.instance.register_page_type self, 'catalog_normal', 'Каталог', "Страница каталогом", 'catalog#catalog_with_section'

      @substitutions.push RubalCore::RubalSubstitution.new(self, "size", "<%= @catalog.size %>", "Количество новостей", :only => :catalog_normal)

    end
  end
end

RubalCatalogPlugin::RubalCatalog.new
