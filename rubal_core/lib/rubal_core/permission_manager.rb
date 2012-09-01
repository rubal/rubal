require_relative "../rubal_core"

module RubalCore
  require "singleton"
  class PermissionManager
    include Singleton
    @permissions

    attr_reader :permissions

    def initialize
      @permissions = []
    end

    def add_permission plugin, name, description, key, contollers, default_access = :admins
      fail "Strange plugin" unless plugin.is_a? RubalPlugin
      fail "Strange access level" unless RubalCore::Settings.instance[:basic_user_groups].include? default_access
      plugin_name = plugin.get_description[:plugin_substitution_name]

      @permissions.push({:plugin_name => plugin_name, :name => name, :description => description, :key => key, :allowed_controllers => contollers, :default_access => default_access})
    end
  end
end