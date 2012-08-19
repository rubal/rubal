# This migration comes from rubal_catalog_plugin (originally 20120818064003)
class AddAttachmentDataToPhotos < ActiveRecord::Migration
  def self.up
    change_table :rubal_catalog_plugin_photos do |t|
      t.has_attached_file :data
    end
  end

  def self.down
    drop_attached_file :rubal_catalog_plugin_photos, :data
  end
end
