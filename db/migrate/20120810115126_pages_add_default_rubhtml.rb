class PagesAddDefaultRubhtml < ActiveRecord::Migration
  def up
    remove_column :pages, :rubhtml_content
    add_column :pages, :rubhtml_content, :string, :null => false, :default => ""
  end

  def down
  end
end
