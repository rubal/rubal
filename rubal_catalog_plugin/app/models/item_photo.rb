class ItemPhoto < ActiveRecord::Base
  belongs_to :item
  attr_accessible :name, :data
  has_attached_file :data, :styles => { :original => "1000x1000>", :medium => "300x300", :thumb => "100x100" }
end
