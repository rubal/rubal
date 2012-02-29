class PagesAddRole < ActiveRecord::Migration
  def up
    add_column :pages, :role, :integer, { :null => false, :default => 1}
    Page.reset_column_information
    Page.all.each do |p|
      p.update_attribute :role, 1
    end
  end

  def down
  end
end
