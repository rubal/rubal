require_relative "../../rubal_core/lib/rubal_core/rubal_model"
require "pages_helper"

class Page < ActiveRecord::Base
  include PagesHelper
  belongs_to :layout, :class_name => 'Page'
  serialize :additional_params, Hash

  #has_one :type, :class_name => 'PageType', :foreign_key => 'type_id'
  attr_accessible :erb_path, :name, :title, :type_id, :url, :rubhtml_content, :layout_id

  rubal_erb_content :erb_content, :path_field => :erb_path, :from => :rubhtml_content
  #rubal_rubhtml_content :rubhtml_content, :path_field => :rubhtml_path

  #def layout_id
  #  return nil if self.layout.nil?
  #  return self.layout.id
  #end
  #
  #def layout_id= val
  #  self.layout = Page.find(val)
  #end

  def type
    unless @type_id.nil?
      return PageType.find(type_id).humanized_name
    else
      return ""
    end
    #raise "the page has strange type"
  end
  #
  #def type= t
  #  if((page_types).include? type)
  #    self.type_id= (page_types)[t][:id]
  #  else
  #    raise "trying to set strange page type"
  #  end
  #end

end
