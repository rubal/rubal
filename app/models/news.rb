class News < ActiveRecord::Base
  #before_filter :authenticate_user!
  validates :header, :presence => true
  validates :full_text, :presence => true
end
