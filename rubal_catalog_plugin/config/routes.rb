Rails.application.routes.draw do
  scope '/admin' do
    match "/items/new_in_section/:section_key" => 'items#new', :as => :create_item_in_section
    resources :items
    resources :catalog_sections
  end
end
