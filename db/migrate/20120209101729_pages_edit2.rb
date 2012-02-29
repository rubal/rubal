class PagesEdit2 < ActiveRecord::Migration
  def up
    Page.reset_column_information
    Page.all.each do |p|
      p.update_attribute :url, p.name + ".html"
    end
  end

  def down
  end
end
