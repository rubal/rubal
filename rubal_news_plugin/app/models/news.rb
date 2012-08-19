class News < ActiveRecord::Base
  belongs_to :trend
  attr_accessible :content, :header, :trend_id
end
