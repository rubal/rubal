class RegistrationsController < Devise::RegistrationsController
  alias :working_new :new
  def new
      flash[:info] = 'Registrations are not open yet, but please check back soon'
      redirect_to root_path
  end

  def create
    flash[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end
end