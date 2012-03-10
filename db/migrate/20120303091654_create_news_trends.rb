class CreateNewsTrends < ActiveRecord::Migration
  def change
    create_table :news_trends do |t|
      t.string :key
      t.string :name
      t.references :full_template
      t.references :short_template

      t.timestamps
    end
    add_index :news_trends, :full_template_id
    add_index :news_trends, :short_template_id
  end
end
