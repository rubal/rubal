# This migration comes from rubal_catalog_plugin_engine (originally 20120822081305)
class CreateCatalogSections < ActiveRecord::Migration
  def change
    create_table :catalog_sections do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
