class RubalAdminController < ApplicationController
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

  def devise_sign_out
    sign_out(current_user)
    redirect_to '/'
  end

  def index
    render :inline => "<h1>ADMIIIIN</h1>"
  end
end
