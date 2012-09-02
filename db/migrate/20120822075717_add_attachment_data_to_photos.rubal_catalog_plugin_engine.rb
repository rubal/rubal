# This migration comes from rubal_catalog_plugin_engine (originally 20120822074232)
class AddAttachmentDataToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.has_attached_file :data
    end
  end

  def self.down
    drop_attached_file :photos, :data
  end
end
