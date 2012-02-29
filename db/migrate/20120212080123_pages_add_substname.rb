class PagesAddSubstname < ActiveRecord::Migration
  def up
    add_column :pages, :subst_name, :string
    Page.reset_column_information
  end

  def down
    remove_column :pages, :subst_name, :string
  end
end
