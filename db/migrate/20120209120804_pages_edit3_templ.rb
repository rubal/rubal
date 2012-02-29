class PagesEdit3Templ < ActiveRecord::Migration
  def up
    remove_column :pages, :parent, :references
    add_column :pages, :template, :integer
    Page.reset_column_information
    #Page.all.each do |p|
    #  p.update_attribute :template, 
    #end
  end

  def down
    remove_column :pages, :template, :integer
  end
end