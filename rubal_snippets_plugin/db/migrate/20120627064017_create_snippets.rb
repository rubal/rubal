class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.string :subst_name
      t.string :path
      t.text :description

      t.timestamps
    end
  end
end
