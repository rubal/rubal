require_relative "../../lib/rubal_core"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  belongs_to :user_group, :class_name => 'UserGroup'
  # attr_accessible :title, :body

  before_save do
    self.user_group_id = UserGroup.find_by_key(RubalCore::Settings.instance[:basic_user_groups][:members][:key]).id if self.new_record? && user_group.nil?
  end
end
