class Item < ActiveRecord::Base
  belongs_to :section, :class_name => 'CatalogSection'
  attr_accessible :description, :name, :price, :section_id, :photos_attributes
  has_many :photos, :class_name => 'ItemPhoto', :dependent => :destroy

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |attributes| attributes['data'].blank? and attributes['_destroy'].blank? }
end
