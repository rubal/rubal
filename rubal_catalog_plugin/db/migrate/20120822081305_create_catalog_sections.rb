class CreateCatalogSections < ActiveRecord::Migration
  def change
    create_table :catalog_sections do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
