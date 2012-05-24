class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :id
      t.datetime :date
      t.string :header
      t.text :short_text
      t.text :full_text

      t.timestamps
    end
  end
end
