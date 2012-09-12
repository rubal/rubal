require_relative "../../rubal_core/lib/rubal_core"

if ActiveRecord::Base.connection.tables.include?('page_types') and !defined?(::Rake)
  # your code goes here
  RubalCore::PluginManager.instance.create_or_update_page_types
end