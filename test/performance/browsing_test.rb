require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
   self.profile_options = { :runs => 1, :metrics => [:wall_time, :memory], :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    get '/p.html'
  end
end
