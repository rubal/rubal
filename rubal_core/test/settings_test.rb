require 'test_helper'
require 'rubal_core/settings'

include RubalCore
# Запуск тестов (набирать из корня проекта): ruby -Itest test/unit/settings_test.rb

class PostTest < ActiveSupport::TestCase

  TestSettingsFile = 'test/settings_test_db.rb'
  TestSettingsSavedFile = 'test/settings_test_db_saved.rb'

  RequiredStr =<<file
{:common=>
	{:cms_name=>"rubal"},
:news=>
	{:news_on_page=>1488,
	:installed=>false},
:cache=>
	{:cache_by_dafault=>false,
	:auto_update=>true,
	:auto_update_time=>86400},
}
file


  test "load" do
    settings = Settings.instance
    settings.load TestSettingsFile

    assert 86400==settings[:cache][:auto_update_time], "Source code executing failure"
    assert "rubal"==settings[:common][:cms_name], "String param"
    assert !settings[:news][:installed], "Bool param(false)"
    assert settings[:cache][:auto_update], "Bool param(true)"
    assert 1488==settings[:news][:news_on_page], "Integer param(true)"
  end

  test "save" do
    settings = Settings.instance
    settings.load TestSettingsFile

    settings.save TestSettingsSavedFile
    str = File.read TestSettingsSavedFile
    assert RequiredStr==str, "RequiredStr!=str: '#{RequiredStr}'!='#{str}'"
  end

  test "add category" do
    settings = Settings.instance
    settings.load TestSettingsFile

    settings.add_category (SettingsCategory.new :test_category, {})
    assert SettingsCategory==settings[:test_category].class, "Category must be SettingsCategory instance"

    settings[:test_category][:test_param] = 1488
    assert 1488==settings[:test_category][:test_param], "Insert into empty category"

    assert :test_category==settings[:test_category].name, "attr_reader :name"

    assert_raise( NoMethodError, "Adding param to nonexistent category" ) {
      settings[:not_added_category][:test_param] = 1488
    }

    assert_raise( TypeError, "Category must be SettingsCategory instance" ) {
      settings.add_category 'Non_SettingsCategory_instance'
    }
  end

  test "remove category" do
    settings = Settings.instance
    settings.load TestSettingsFile

    settings.remove_category :common
    assert !settings.key?(:common), "Removing category :common"

    settings.remove_category :unknown_category #TODO: catch this situation
  end

end
