# This migration comes from rubal_catalog_plugin_engine (originally 20120822074135)
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.integer :item_id

      t.timestamps
    end
  end
end
