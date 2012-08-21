RubalCatalogPlugin::Engine.routes.draw do
  scope '/admin' do
    resources :items
  end
end
