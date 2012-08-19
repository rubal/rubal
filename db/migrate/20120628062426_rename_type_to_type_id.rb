class RenameTypeToTypeId < ActiveRecord::Migration
  def up
    rename_column :pages, :type, :type_id
  end

  def down
    rename_column :pages, :type_id, :type
  end
end
