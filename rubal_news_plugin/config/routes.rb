Rails.application.routes.draw do
  scope '/admin' do
    resources :news_trends
    resources :news
  end
end
