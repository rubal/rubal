require File.expand_path("rubal_core/lib/rubal_core/rubal_model", Rails.root.to_s)

class Snippet < ActiveRecord::Base
  attr_accessible :description, :name, :path, :subst_name, :erb_content
  rubal_erb_content :erb_content, :path_field => :path
end
