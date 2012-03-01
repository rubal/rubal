class NewsAddTrend < ActiveRecord::Migration
  def up
    add_column :news, :trend_name, :string, :default => 'news'
  end

  def down
    remove_column :news, :trend_name, :string
  end
end
