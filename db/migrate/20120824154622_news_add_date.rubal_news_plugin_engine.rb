# This migration comes from rubal_news_plugin_engine (originally 20120824154326)
class NewsAddDate < ActiveRecord::Migration
  def change
    add_column :news, :date, :datetime
  end

end
