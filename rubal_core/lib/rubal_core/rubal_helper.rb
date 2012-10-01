module RubalCore::RubalHelper
  require_relative "../rubal_core"

  def current_user_group
    (current_user.nil?) ? UserGroup.find_by_key(RubalCore::Settings.instance[:basic_user_groups][:guests][:key]) : current_user.user_group
  end

  def access_allowed? user_group, target_page
    return true if user_group.key == RubalCore::Settings.instance[:basic_user_groups][:admins][:key]

    (return true if self.class.name.split("::").first == "Devise") unless self.class.name.nil?

    color_log(target_page.to_s, :red)

    target_controller = nil

    if target_page.kind_of? String
      target_controller = Rails.application.routes.recognize_path(target_page)
    elsif target_page.kind_of? Hash
      if target_page.include?(:controller) && target_page.include?(:action)
        target_controller = target_page
      end
    end

    if target_controller.nil?
      Rails.logger.warn("unknown page for authorization - #{target_page.to_s}")
      return false
    end



    permissions = user_group.permissions

    permissions.each do |permission|
      puts permission.params[:controllers].to_s
      unless permission.params[:controllers].nil?
        if permission.params[:controllers].include?(target_controller[:controller].to_s)
          return true if permission.params[:controllers][target_controller[:controller].to_s].include?(target_controller[:action].to_s)
        end
      end
    end
    false
  end

  def if_allowed_for_user(url, &block)
    allowed = (access_allowed?(current_user_group, ((url.kind_of?(Symbol)) ? url_for(url) : url)))
    if (block_given? && allowed)
      block.call()
    else
      return allowed
    end
  end
end
