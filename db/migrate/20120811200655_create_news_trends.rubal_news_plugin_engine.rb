# This migration comes from rubal_news_plugin_engine (originally 20120811200607)
class CreateNewsTrends < ActiveRecord::Migration
  def change
    create_table :news_trends do |t|
      t.string :name

      t.timestamps
    end
  end
end
