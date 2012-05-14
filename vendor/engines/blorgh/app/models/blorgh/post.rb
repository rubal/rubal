module Blorgh
  class Post < ActiveRecord::Base
    attr_accessible :text, :title
    has_many :comments
  end
end
