class AdminController < ApplicationController
  before_filter :authenticate_user!
  def new_user
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
  
  def create_user
    @user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password])
    @user.save

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
end
