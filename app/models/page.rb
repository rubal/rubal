require_relative "../../rubal_core/lib/rubal_core/rubal_model"
require "pages_helper"

class Page < ActiveRecord::Base
  include PagesHelper

  validate :name, :presence  => true

  belongs_to :layout, :class_name => 'Page'
  serialize :additional_params, Hash

  #has_one :type, :class_name => 'PageType', :foreign_key => 'type_id'
  attr_accessible :erb_path, :name, :title, :type_id, :url, :rubhtml_content, :layout_id

  #attr_accessor :erb_hash

  rubal_erb_content :erb_content, :path_field => :erb_path, :from_field => :rubhtml_content, :erb_hash_field => :erb_hash=

  def type
    unless @type_id.nil?
      return PageType.find(type_id).humanized_name
    else
      return ""
    end
    #raise "the page has strange type"
  end

end
