class ApplicationController < ActionController::Base
  protect_from_forgery

  require_dependency 'rubal_core'

  # add instance methods
  include RubalCore::Authorization
  include RubalCore::RubalController
  include RubalCore::RubalHelper
  before_filter :rubal_authenticate
end