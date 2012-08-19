require "rubal_core/engine"
require "rubal_core/authorization"
module RubalCore
  autoload :PluginManager, "rubal_core/plugin_manager"
  autoload :PageProcessor, "rubal_core/page_processor"
  autoload :RubalPlugin, "rubal_core/rubal_plugin"
  autoload :RubalSubstitution, "rubal_core/substitutions"
  autoload :RubalSubstitutionViewRender, "rubal_core/substitutions"
  autoload :RubalSubstitutionWithParams, "rubal_core/substitutions"
  autoload :FileHelper, "rubal_core/files_helper"
  autoload :PageType, File.expand_path("rubal_core/app/models/page_type", Rails.root.to_s)
end

