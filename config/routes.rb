#require 'rubal_core'
#require 'rubal_core/lib/rubal_core/plugin_manager'

Rubal::Application.routes.draw do

  devise_for :admins

  devise_for :users

  resources :pages

  resources :thepages

  resources :page_plugin_relations

  get "admin/index"
  get "admin/admin"

  # получаем массив путей, установленных плагинами
  #routes_arr = PluginManager.instance.get_hash_array_routes

  #routes_arr = PluginManager.instance.routes
  #routes_arr.each { |el|
  #  match el
  #}

  match 'page_plugin_relations/:id' => 'page_plugin_relations#index'
  match 'pageediting' => 'page_editing#index'
  match 'thepages/' => 'thepages#index'
  match 'thepages/vhtml_edit/:id' => 'thepages#vhtml_edit'
  mount Blorgh::Engine, :at => "/blorgh"


  #match 'page/' => 'page_plugin_relations#index'

  #match "admin/rubal_test_plugin/:id" => "admin#say_hello_admin"
  #match "admin/r" => "admin#r"

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
  root :to => 'admin#admin'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
