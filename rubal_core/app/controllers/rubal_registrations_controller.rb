class RubalRegistrationsController < Devise::RegistrationsController
  alias :devise_new :new
  alias :devise_create :create

  def new
    if params[:a].blank?
      devise_new
    else
      flash[:info] = 'Registrations are not open yet, but please check back soon'
      redirect_to :admin
    end
  end

  def create
    if params[:a].blank?
      devise_create
    else
      flash[:info] = 'Registrations are not open yet, but please check back soon'
      redirect_to :admin
    end
  end
end