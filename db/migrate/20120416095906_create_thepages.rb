class CreateThepages < ActiveRecord::Migration
  def change
    create_table :thepages do |t|
      t.integer :id
      t.string :erb_path
      t.string :vhtml_path
      t.string :page_url
      t.string :used_plugins
      t.string :page_title
      t.string :html_returned_by_plugins
      t.integer :parent_page

      t.timestamps
    end
  end
end
