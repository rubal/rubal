require File.expand_path("rubal_core/lib/rubal_core", Rails.root.to_s)
include RubalCore::RubalLogger
RubalLi::Application.routes.draw do
  get '/pages/perf_test_create'
  scope '/admin' do
    match "/pages/:id/edit/html" => 'pages#edit', :edit_html => true, :as => :page_edit_html
    match "/pages/new/:page_type" => 'pages#new', :as => :new_page_type
    resources :pages
    get "/pages/clear"
    match "/reload" => 'pages#reload'
  end


  RubalCore::PluginManager.instance.get_routing_rules.each_pair{|page_type, processor|
    Page.find_all_by_type_id(PageType.find_by_name(page_type.to_s).id).each{|p|
      color_log("Building routes for " + page_type, :green)
      if processor.kind_of? String
        match p.url + ".html" => processor, :url => p.url
        root :to => processor, :url => p.url if p.url.downcase == 'index'
      elsif (processor.kind_of? Proc)
        #begin
          processor.call(self, p.url)
        #rescue
          # TODO : записать в лог
        #end

      end
    }
  }



  match "/:url.html" => 'pages#show'

  match "/permission_denied" => 'pages#permission_denied'

  root :to => 'pages#show', :url => 'index'
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
