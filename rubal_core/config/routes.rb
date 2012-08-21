Rails.application.routes.draw do
  scope '/admin' do
    devise_for :users
    resources :page_contents
  end
end
