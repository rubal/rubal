#encoding: utf-8
include PagesRoles
class AdressValidator < ActiveModel::Validator
  def validate (page)
    roles = roles_hash
    if page.role == roles[:page]["id"]
      if page.url.nil?
        page.errors[:url] << 'может содержать только буквы латинского алфавита, цифры, _ и -'  if page page.url.match('^[a-zA-Z\-_0-9]*$').nil?
      end
    elsif page.role == roles[:chunk]["id"]
      if page.subst_name.nil? || page.subst_name.match('^[a-zA-Z\-_0-9]*$').nil?
        page.errors[:subst_name] << 'может содержать только буквы латинского алфавита, цифры, _, - и не должно быть пустым'
      end
    elsif page.role == roles[:template]["id"]
      if !page.template.nil? && page.template == page.id
        page.errors[:template] << 'нельзя назначить самому себе'
      end
    end
  end
end

class Page < ActiveRecord::Base
  attr_accessor :page_content, :additional_params, :roles
  validates :name, :presence => true
  validates :page_content, :presence => true
  include ActiveModel::Validations
  validates_with AdressValidator
  
  HUMANIZED_ATTRIBUTES = {
    :url => "URL",
    :subst_name => "Имя подстановки",
    :name => "Название",
    :title => "Заголовок",
    :page_content => "Контент",
    :template => "Шаблон"
  }

  def self.human_attribute_name (attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
end



  