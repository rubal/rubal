# This migration comes from rubal_catalog_plugin_engine (originally 20120822074531)
class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.references :section

      t.timestamps
    end
    add_index :items, :section_id
  end
end
