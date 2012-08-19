class CreatePluginInfos < ActiveRecord::Migration
  def change
    create_table :plugin_infos do |t|
      t.string :full_name
      t.string :subst_name
      t.string :path
      t.string :resources_path

      t.timestamps
    end
  end
end
