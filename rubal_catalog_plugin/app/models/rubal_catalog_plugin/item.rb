module RubalCatalogPlugin
  class Item < ActiveRecord::Base
    belongs_to :section
    attr_accessible :description, :name, :price
  end
end
