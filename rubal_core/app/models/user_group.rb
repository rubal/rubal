class UserGroup < ActiveRecord::Base
  attr_accessible :key, :name
  has_many :users

  serialize :params, Hash

  validates :key, :name, :presence => true
  validates :key, :name, :uniqueness => true

  has_and_belongs_to_many :permissions
end
