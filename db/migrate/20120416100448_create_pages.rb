class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :id
      t.string :erb_path
      t.string :vhtml_path
      t.string :page_url
      t.string :used_plugins
      t.string :page_title
      t.integer :parent_page

      t.timestamps
    end
  end
end
