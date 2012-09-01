require_relative "../../lib/rubal_core"

class Permission < ActiveRecord::Base
  attr_accessible :description, :key, :name, :plugin_name, :allowed_controllers, :default_access
  validates :key, :name, :uniqueness => true
  validates :key, :name, :plugin_name, :presence => true
  serialize :params, Hash

  has_and_belongs_to_many :user_groups

  def allowed_controllers= contrls
    params[:controllers] = {}
    if contrls.kind_of? Hash
      contrls.each_pair do |controller, actions|
        actions = [actions] if actions.kind_of?(Symbol) || actions.kind_of?(String)

        actions.map! {|a| a.to_s}

        if params[:controllers].include? controller.to_s
          params[:controllers][controller.to_s] += actions
        else
          params[:controllers][controller.to_s] = actions
        end
      end
    elsif contrls.kind_of? Array
      contrls.each do |cs|
        cs_arr = cs.split('#')
        fail 'strange controller' unless cs_arr.size == 2
        if params[:controllers].include? cs_arr[0]
          params[:controllers][controller.to_s].push cs_arr[1]
        else
          params[:controllers][cs_arr[0]] = [cs_arr[1]]
        end
      end
    end
  end

  def allowed_controllers
    params[:controllers]
  end

  def default_access= group
    if (group.to_sym != :admins &&  self.new_record?)
      if (RubalCore::Settings.instance[:basic_user_groups].include?(group.to_sym))
        self.user_groups= [UserGroup.find_by_key(RubalCore::Settings.instance[:basic_user_groups][group.to_sym][:key])]
      else
        fail "strange group"
      end
    end
  end
end
