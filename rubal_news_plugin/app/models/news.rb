class News < ActiveRecord::Base
  belongs_to :trend, :class_name => 'NewsTrend'
  attr_accessible :content, :header, :trend_id, :date
end
