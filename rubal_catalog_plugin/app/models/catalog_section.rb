class CatalogSection < ActiveRecord::Base
  attr_accessible :description, :name, :key
  has_many :items

  before_save do
    self.key= self.key.downcase unless self.key.blank?
  end


  def to_s
    name
  end
end
