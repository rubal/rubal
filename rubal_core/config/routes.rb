Rails.application.routes.draw do
  scope '/admin' do
    devise_for :users
  end
end
