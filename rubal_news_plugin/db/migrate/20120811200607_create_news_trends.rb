class CreateNewsTrends < ActiveRecord::Migration
  def change
    create_table :news_trends do |t|
      t.string :name

      t.timestamps
    end
  end
end
