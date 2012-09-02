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
