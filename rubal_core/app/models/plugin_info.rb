class PluginInfo < ActiveRecord::Base
  attr_accessible :full_name, :path, :resources_path, :subst_name
end
