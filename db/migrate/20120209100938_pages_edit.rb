class PagesEdit < ActiveRecord::Migration
  def up
    add_column :pages, :url, :string
    Page.reset_column_information
    Page.all.each do |p|
      p.update_attribute :url, p.name + ".html"
    end
  end

  def down
    remove_column :pages, :url, :string
  end
end
