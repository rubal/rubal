class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.string :url
      t.integer :type
      t.references :layout
      t.string :erb_path
      t.string :rubhtml_path

      t.timestamps
    end
    add_index :pages, :layout_id
  end
end
