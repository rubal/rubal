# This migration comes from rubal_core_engine (originally 20120826140316)
class UsersAddGroup < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :integer
  end
end
