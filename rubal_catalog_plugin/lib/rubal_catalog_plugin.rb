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

      routes_for_browse = lambda {|route_class, url|
        route_class.send :match, "/#{url}/:section_key.html" => "items#browse_section", :url => url
      }

      RubalCore::PluginManager.instance.register_page_type self, 'catalog_all', 'Каталог, все секции', "Страница с каталогом", 'items#browse_all'
      RubalCore::PluginManager.instance.register_page_type self, 'catalog_section', 'Каталог, конкретная секция', "Каталог, конкретная секция", routes_for_browse

      @substitutions.push RubalCore::RubalSubstitution.new(self, "size", "<%= @catalog.size %>", "Количество новостей", :only => :catalog_normal)

      @substitutions.push RubalCore::RubalSubstitution.new(self, "section_name", "<%= @selected_section.name %>", "Имя секции", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "items_begin", "<% @items.each{|item| %>", "Начало вывода предметов", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "items_end", "<% } %>", "Окончание вывода предметов", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_name", "<%= item.name %>", "Название предмета", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_description", "<%= item.description %>", "Описание предмета", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_price", "<%= format(\"%.2f\",item.price) %>", "Цена предмета", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_photos_begin", "<% item.photos.each{|photo| %>", "Начало вывода фотографий предмета", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_photos_end", "<% } %>", "Окончание вывода фотографий предмета", :only => :catalog_section)

      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_photo_name", "<%= photo.name %>", "Название фотографии", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_photo_url_large", "<%= photo.data.url(:original) %>", "URL фотографии original размер", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_photo_url_medium", "<%= photo.data.url(:medium) %>", "URL фотографии medium размер", :only => :catalog_section)
      @substitutions.push RubalCore::RubalSubstitution.new(self, "item_photo_url_thumb", "<%= photo.data.url(:thumb) %>", "URL фотографии thumb размер", :only => :catalog_section)

      RubalCore::PluginManager.instance.register_menu_node('Каталог', :items, [:name => 'Секции', :url => :catalog_sections])


    end
  end
end

RubalCatalogPlugin::RubalCatalog.new
