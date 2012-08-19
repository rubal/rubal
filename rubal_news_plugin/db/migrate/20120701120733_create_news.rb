class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :header
      t.integer :trend_id
      t.text :content

      t.timestamps
    end
  end
end
