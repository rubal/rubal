require 'test_helper'
require 'rubal_core/plugin_manager'

include RubalCore

class PluginManagerTest < ActiveSupport::TestCase

  test "add placeholder" do
    pm = PluginManager.instance

    pm.add_placeholder 'category', 'param', 'value'
    assert pm.placeholders.has_key?('category') #TODO: assert failure message
    assert pm.placeholders['category'].has_key?('param') #TODO: assert failure message
    assert 'value'==pm.placeholders['category']['param'] #TODO: assert failure message

    pm.add_placeholder 'category', 'news', '<% get_news %>'
    assert pm.placeholders['category'].has_key?('news') #TODO: assert failure message
    assert '<% get_news %>'==pm.placeholders['category']['news'] #TODO: assert failure message
  end


  test "add route" do
    pm = PluginManager.instance

    TEST_ROUTE = {"admin/test_route" => "admin#i_m_not_callable"}
    pm.add_route TEST_ROUTE
    assert pm.routes.pop.eql? TEST_ROUTE #TODO: assert failure message
  end


end