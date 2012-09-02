# This migration comes from rubal_catalog_plugin_engine (originally 20120823073747)
class SectionAddKey < ActiveRecord::Migration
  def up
    add_column :catalog_sections, :key, :string
  end

  def down
    remove_column :catalog_sections, :key
  end
end
