class CreatePageTypes < ActiveRecord::Migration
  def change
    create_table :page_types do |t|
      t.string :name
      t.string :humanized_name
      t.string :description
      t.string :plugin_name
      t.text :substitutions_params

      t.timestamps
    end
  end
end
