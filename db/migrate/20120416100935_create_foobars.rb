class CreateFoobars < ActiveRecord::Migration
  def change
    create_table :foobars do |t|
      t.integer :id
      t.string :title

      t.timestamps
    end
  end
end
