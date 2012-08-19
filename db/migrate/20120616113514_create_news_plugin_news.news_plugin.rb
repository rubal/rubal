# This migration comes from news_plugin (originally 20120616104213)
class CreateNewsPluginNews < ActiveRecord::Migration
  def change
    create_table :news_plugin_news do |t|
      t.string :header
      t.text :full_text

      t.timestamps
    end
  end
end
