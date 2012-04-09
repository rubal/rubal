
require 'test_helper'
require Rails.root.to_s + '/lib/assets/settings'

# Запуск тестов (набирать из корня проекта): ruby -Itest test/unit/*

class PostTest < ActiveSupport::TestCase


  test "load settings" do
    settings = Settings.instance

    assert false, settings.to_s
  end
end