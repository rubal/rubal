class CreatePagePluginRelations < ActiveRecord::Migration
  def change
    create_table :page_plugin_relations do |t|
      t.integer :pid
      t.string :plugin_name
      t.string :plugin_params
      t.string :plugin_returned_html

      t.timestamps
    end
  end
end
