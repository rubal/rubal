Rails.application.routes.draw do
  scope '/admin' do
    resources :snippets
  end
end
