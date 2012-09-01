class UsersAddGroup < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :integer
  end
end
