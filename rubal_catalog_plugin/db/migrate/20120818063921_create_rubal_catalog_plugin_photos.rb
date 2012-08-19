class CreateRubalCatalogPluginPhotos < ActiveRecord::Migration
  def change
    create_table :rubal_catalog_plugin_photos do |t|
      t.string :name
      t.references :item

      t.timestamps
    end
    add_index :rubal_catalog_plugin_photos, :item_id
  end
end
