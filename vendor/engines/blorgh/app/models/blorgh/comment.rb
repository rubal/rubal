module Blorgh
  class Comment < ActiveRecord::Base
    attr_accessible :post_id, :text
  end
end
