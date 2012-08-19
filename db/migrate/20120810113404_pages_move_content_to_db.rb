class PagesMoveContentToDb < ActiveRecord::Migration
  def up
    remove_column :pages, :rubhtml_path
    add_column :pages, :rubhtml_content, :text
  end

  def down
  end
end
