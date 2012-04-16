class CreateNewsNews < ActiveRecord::Migration
  def change
    create_table :news_news, :force => true do |t|
      t.integer :id
      t.datetime :date
      t.string :header
      t.text :short_text
      t.text :full_text

      t.timestamps
    end
  end
end
