# This migration comes from rubal_catalog_plugin_engine (originally 20120914151700)
class ItemAddMainPhoto < ActiveRecord::Migration
  def change
    add_column :items, :main_photo_id, :integer
  end
end
