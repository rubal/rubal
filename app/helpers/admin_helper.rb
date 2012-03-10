require 'loaded/ModuleTest'
include ModuleTest
module AdminHelper
  def tt
    return test_method
  end
end
