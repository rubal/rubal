class ItemAddMainPhoto < ActiveRecord::Migration
  def change
    add_column :items, :main_photo_id, :integer
  end
end
