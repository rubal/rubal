class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :name
      t.text :content
      t.integer :page_id

      t.timestamps
    end
  end
end
