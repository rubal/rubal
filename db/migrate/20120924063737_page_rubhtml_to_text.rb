class PageRubhtmlToText < ActiveRecord::Migration
  def change
    change_column :pages, :rubhtml_content, :text
  end
end
