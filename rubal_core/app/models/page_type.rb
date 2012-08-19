class PageType < ActiveRecord::Base
  attr_accessible :description, :humanized_name, :name, :plugin_name, :substitutions_params
  serialize :substitutions_params, Hash
end
