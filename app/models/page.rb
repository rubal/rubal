require_relative "../../rubal_core/lib/rubal_core/rubal_model"
require "pages_helper"

class Page < ActiveRecord::Base
  include PagesHelper

  validate :name, :presence  => true

  belongs_to :layout, :class_name => 'Page'
  serialize :additional_params, Hash

  belongs_to :type, :class_name => 'PageType', :foreign_key => 'type_id'
  attr_accessible :erb_path, :name, :title, :type_id, :url, :rubhtml_content, :layout_id

  #attr_accessor :erb_hash

  rubal_erb_content :erb_content, :path_field => :erb_path, :from_field => :rubhtml_content, :erb_hash_field => :erb_hash=

  def params_for_type_before_save= params
    @params_for_type_before_save = params
  end

  def url
    read_attribute(:url) || ''
  end

  before_save do
    unless type.after_save.nil?
      puts "AAAAAAAAAA"
      puts @params_for_type_before_save
      type.after_save.call(@params_for_type_before_save, self)
    end
  end

end
