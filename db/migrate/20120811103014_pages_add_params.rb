class PagesAddParams < ActiveRecord::Migration
  def up
    add_column :pages, :additional_params, :text
  end

  def down
    remove_column :pages, :additional_params
  end
end
