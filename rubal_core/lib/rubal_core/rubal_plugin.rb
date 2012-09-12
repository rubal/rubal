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
end

