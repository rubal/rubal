require 'singleton'
module RubalCore
  class PluginManager
    include Singleton

    attr_reader :routes,:placeholders,:plugins
    # Действия плагинов для админки
    module AdminExtend

    end
    # Действия плагинов для страниц
    module PageExtend

    end
    # Инициализируем пути и плейсхолдеры
    def initialize
      @routes = Array.new([{"admin/call/:id" => "admin#call_me_baybe"}, {"admin/i" => "admin#index"}])
      @placeholders = {}
    end

    # Добавление действий плагинов в AdminController.
    # Получает модуль в качестве параметра.
    def add_admin_controller given_module
      AdminExtend.send :include, given_module

    end
    # Добавление действий плагинов в PageController.
    # Получает модуль в качестве параметра.
    def add_page_controller given_module
      PageExtend.send :include, given_module
    end

    # Add route to CMS
    # * route  #TODO: add doc
    # Добавляем пути всех плагинов в плагинменеджер
    def add_route route
      @routes.push(route)
    end
    # Возвращает массив путей всех плагинов
    def get_hash_array_routes
      @routes
    end
    # Add placeholder from plugin to CMS
    # * category #TODO: add doc
    # * param #TODO: add doc
    # * value #TODO: add doc
    def add_placeholder category, param, value
      raise TypeError unless (category.instance_of? String) && (param.instance_of? String) && (value.instance_of? String)
      @placeholders[category]={} unless @placeholders.has_key? category
      @placeholders[category][param] = value
    end

    def add_plugin plugin_instance
      @plugins=[] if @plugins.nil?
      @plugins.push plugin_instance
      # todo: добавление модуля плагина здесь(при добавлении плагина)
      #self.add_admin_controller plugin_instance::Methods
    end
    # возвращаем значение плейсхолдера по указанным категории и параметру
    def get_placeholder_value category, param
      # проверка переданных параметров
      if category.nil? || param.nil?
        return
      end
      # возвращаем значение плейсхолдера по указанным категории и параметру (если оно не nil)
      @placeholders[category][param] unless @placeholders[category][param].nil?
      #@placeholders.each{|placeholder|
      #  if placeholder[:category] == category && placeholder[:param] == param
      #    placeholder[:value]
      #  end
      #}
    end
  end
end
