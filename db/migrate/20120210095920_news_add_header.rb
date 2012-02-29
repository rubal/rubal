class NewsAddHeader < ActiveRecord::Migration
  def up
    add_column :news, :header, :string
    News.reset_column_information
  end

  def down
  end
end
