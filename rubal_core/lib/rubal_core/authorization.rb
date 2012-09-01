module RubalCore
  module Authorization
    require "devise"
    include Devise

    def rubal_authenticate
      if current_user.nil?
        unless access_allowed?(current_user_group, {:controller => controller_name, :action => action_name})
          authenticate_user!
        end
      else
        authenticate_user!
        permission_denied unless access_allowed?(current_user_group, {:controller => controller_name, :action => action_name})
      end
      #
      #authenticate_user!
      #puts Rails.application.routes.recognize_path("/admin/pages", :method => :get).to_s
      #if true
      #  #permission_denied
      #end
      #puts "M"*100
      #puts controller_name
      #puts action_name
      #puts controller_path
      #access_allowed? 'ff'
    end

    def permission_denied
      r_t = RubalCore::Settings.instance[:pages][:redirect_on_permission_denied]
      r_t ||= '/'
      redirect_to r_t
      false
    end
  end

  #module GroupPermissions
  #  def allow_for_unauthorized contr
  #    if contr.kind_of? Symbol
  #      self.send :skip_before_filter, contr
  #    elsif contr.kind_of? Array
  #      contr.each do |c|
  #        self.send :skip_before_filter, :rubal_authenticate, c if c.kind_of? Symbol
  #      end
  #    end
  #  end
  #end
end