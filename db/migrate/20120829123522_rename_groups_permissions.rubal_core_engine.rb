# This migration comes from rubal_core_engine (originally 20120829123228)
class RenameGroupsPermissions < ActiveRecord::Migration
  def change
    rename_table :user_groups_permissions, :permissions_user_groups
    add_index :permissions_user_groups, [:user_group_id, :permission_id]
    add_index :permissions_user_groups, [:permission_id, :user_group_id]
  end
end
