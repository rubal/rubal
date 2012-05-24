class News < ActiveRecord::Base
  attr_accessible :date, :full_text, :header, :id, :short_text
end
