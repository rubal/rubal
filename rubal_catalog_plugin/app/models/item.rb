class Item < ActiveRecord::Base
  belongs_to :section, :class_name => 'CatalogSection'
  attr_accessible :description, :name, :price, :section_id, :photos_attributes, :main_photo_id
  has_many :photos, :class_name => 'ItemPhoto', :dependent => :destroy

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |attributes| attributes['data'].blank? and attributes['_destroy'].blank? }

  def  main_photo
    return ItemPhoto.find(main_photo_id) unless main_photo_id.blank?
    return self.photos.first unless photos.blank?
    return nil
  end
end

