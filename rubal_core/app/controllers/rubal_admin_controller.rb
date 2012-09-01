class RubalAdminController < ApplicationController
  before_filter do
    #puts action_name
    #puts controller_name
    #puts controller_path
    #puts "-"*10
  end

  def browse_users
    @users = User.order(:created_at)
    @groups = UserGroup.order(:created_at)
  end

  def set_user_group
    # TODO сделать нормально изменение группы

    begin
      user = User.find(params[:user_id])
      user.user_group_id= params[:user_group_id]
      user.save
    rescue
    end

    render :inline => "success"
  end
end
