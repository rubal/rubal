class ApplicationController < ActionController::Base
  protect_from_forgery
  #require_dependency Rails.root.to_s + '/rubal_core/lib/rubal_core/plugin_manager'
  require_dependency 'rubal_core'
  #require_dependency 'news_plugin'
  #require_dependency 'test_engine'
  include RubalCore::Authorization
  before_filter :rubal_authenticate


end
