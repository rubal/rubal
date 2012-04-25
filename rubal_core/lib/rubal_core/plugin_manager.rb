require 'singleton'

module RubalCore
  class PluginManager
    include Singleton

    attr_reader :routes,:placeholders

    module AdminExtend

    end
    module PageExtend

    end

    def initialize
      @routes = Array.new([{"admin/c1/:id" => "admin#call_me_baybe"}, {"admin/i" => "admin#index"}])
      @placeholders = {}
    end

    def add_admin_controller(given_PluginNameAdminControllerExtend)
      AdminExtend.send(:include, given_PluginNameAdminControllerExtend)
    end

    def add_page_controller(given_PluginNamePageControllerExtend)
      PageExtend.send(:include, given_PluginNamePageControllerExtend)
    end

    # Add route to CMS
    # * route  #TODO: add doc
    def add_route route
      @routes.push(route)
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

  end
end
