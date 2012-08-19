class CreateRubalCatalogPluginItems < ActiveRecord::Migration
  def change
    create_table :rubal_catalog_plugin_items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.references :section

      t.timestamps
    end
    add_index :rubal_catalog_plugin_items, :section_id
  end
end
