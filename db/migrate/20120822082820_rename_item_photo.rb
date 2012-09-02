class RenameItemPhoto < ActiveRecord::Migration
  def change
    rename_table :photos, :item_photos
  end
end
