require "rubal_core/engine"
require "rubal_core/authorization"
require "rubal_core/rubal_controller"
require "rubal_core/rubal_helper"
require "rubal_core/logger"

module RubalCore
  autoload :PluginManager, "rubal_core/plugin_manager"
  autoload :PageProcessor, "rubal_core/page_processor"
  autoload :RubalPlugin, "rubal_core/rubal_plugin"
  autoload :RubalSubstitution, "rubal_core/substitutions"
  autoload :RubalSubstitutionViewRender, "rubal_core/substitutions"
  autoload :RubalSubstitutionWithParams, "rubal_core/substitutions"
  autoload :Settings, "rubal_core/settings"
  autoload :FileHelper, "rubal_core/files_helper"
  autoload :RubalMenuNode, "rubal_core/menu"
  autoload :RubalMainMenu, "rubal_core/menu"
  autoload :PermissionManager, "rubal_core/permission_manager"
  autoload :PageType, File.expand_path("rubal_core/app/models/page_type", Rails.root.to_s)
  autoload :PageContent, File.expand_path("rubal_core/app/models/page_content", Rails.root.to_s)

  require "rubal_core/rubal_core_plugins"
end

class ActiveSupport::BufferedLogger
  def formatter=(formatter)
    @log.formatter = formatter
  end
end

