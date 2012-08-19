module RubalCatalogPlugin
  class Photo < ActiveRecord::Base
    belongs_to :item
    attr_accessible :name
  end
end
