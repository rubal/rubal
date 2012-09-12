require_relative "../../lib/rubal_core"

class PageType < ActiveRecord::Base
  attr_accessible :description, :humanized_name, :name, :plugin_name, :substitutions_params
  serialize :substitutions_params, Hash

  def form_params
    @form_params ||= RubalCore::PluginManager.instance.get_page_type_hash(name)[:additional_form_params]
    @form_params ||= {}
    @form_params
  end

  def form_fields
    form_params[:form_fields]
  end

  def additional_form_fields
    form_params[:additional_form_fields]
  end

  def before_save
    form_params[:before_save]
  end

  def to_s
    humanized_name
  end
end
