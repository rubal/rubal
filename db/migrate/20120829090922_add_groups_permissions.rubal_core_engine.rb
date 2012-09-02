# This migration comes from rubal_core_engine (originally 20120829090614)
class AddGroupsPermissions < ActiveRecord::Migration
  def change
    create_table :user_groups_permissions, :id => false do |t|
      t.integer :user_group_id
      t.integer :permission_id
    end
  end
end
