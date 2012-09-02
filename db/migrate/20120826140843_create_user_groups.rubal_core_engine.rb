# This migration comes from rubal_core_engine (originally 20120826140738)
class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.string :name
      t.string :key
      t.text :params

      t.timestamps
    end
  end
end
