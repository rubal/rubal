include RegistrationsHelper

Rubal::Application.routes.draw do

  #devise_for :users

  root :to => 'pages#show', :url => 'index'

  scope "/admin" do
    match 'p/:role/new' => 'pages#new'
    match 'p/:role/create' => 'pages#create'
    match '/new_user' => 'admin#new_user'
    match '/create_user' => 'admin#create_user'
    resources :pages
    resources :pages, :news
    devise_for :users, :controllers  => { :registrations => "registrations" }
  end

  #if true
  #  devise_for :users, :controllers => { :registrations => "registrations" }
  #else
  #  devise_for :users
  #end

  #get "admin/show"
  match '/admin' => 'admin#show'
  #match '/admin/pages/' => 'pages#index'
  #match '/admin/pages/edit/:id' => 'pages#edit'
  #match '/admin/pages/delete/:id' => 'pages#delete'
  #match '/admin/pages/create/' => 'pages#create'
  #resources :news
  #resources :pages
  match '/:url.html' => 'pages#show'
  match '/:url.json' => 'pages#show', :format => 'json'

  match '/:url/:newsid.html' => 'pages#show'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
