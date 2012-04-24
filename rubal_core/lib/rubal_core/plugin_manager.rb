require 'singleton'

class PluginManager
  include Singleton

  module AdminExtend

  end
  module PageExtend

  end
  @routes
  def AddAdminController(given_PluginNameAdminControllerExtend)
    AdminExtend.send(:include, given_PluginNameAdminControllerExtend)
  end
  def AddPageController(given_PluginNamePageControllerExtend)
    PageExtend.send(:include, given_PluginNamePageControllerExtend)
  end
  # добавляем хэш
  def add_hash= hash
    @routes.push(hash)
    #return mn
  end
  def initialize
    @routes = Array.new([{"admin/c1/:id" => "admin#call_me_baybe"}, {"admin/i" => "admin#index"}])
  end
end