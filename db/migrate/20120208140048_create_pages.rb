class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.string :path
      t.references :parent

      t.timestamps
    end
    add_index :pages, :parent_id
  end
end
