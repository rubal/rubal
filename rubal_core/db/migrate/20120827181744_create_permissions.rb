class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :key
      t.string :plugin_name
      t.text :description
      t.text :params

      t.timestamps
    end
  end
end
