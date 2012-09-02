class SectionAddKey < ActiveRecord::Migration
  def up
    add_column :catalog_sections, :key, :string
  end

  def down
    remove_column :catalog_sections, :key
  end
end
