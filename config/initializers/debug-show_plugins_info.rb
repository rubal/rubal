
# TODO: remove it from release

require 'rubal_core/plugin_manager'
include RubalCore

pm = PluginManager.instance

puts 'DEBUG'

puts 'placeholders: ', pm.placeholders
puts 'routes: ', pm.routes

puts 'END DEBUG'
