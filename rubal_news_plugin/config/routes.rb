Rails.application.routes.draw do
  scope '/admin' do
    match "/news/new/in_trend/:selected_trend_id" => "news#new", :as => :create_news_in_trend
    resources :news_trends
    resources :news
  end
end
