class PageAddMd5Hash < ActiveRecord::Migration
  def change
    add_column :pages, :erb_hash, :string
  end
end
